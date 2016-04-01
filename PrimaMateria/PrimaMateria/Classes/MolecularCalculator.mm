//
// MolecularCalculator.mm
// PrimaMateria
//
//  Created by Jerry Porter on 3/22/2010.
//  Copyright 2016 xTrensa. All rights reserved.
//

#include <iostream>
#include <stdexcept>
#import "XTRElement.h"
#import "XTRDataSource.h"
#import "MolecularCalculator.h"

using namespace std;

/*--------------- string -> integer conversion function -----------------*/

/* in case of problems... */
class BadConversion : public std::runtime_error {
public:
BadConversion(const std::string& s)
    : std::runtime_error(s) {
}
};

/* string2integer */
inline int string2integer(const std::string& s) {
    std::istringstream i(s);
    int x;
    if ( !(i >> x) )
        throw BadConversion("string2integer(\"" + s + "\")");
    return x;
}

/*-------------- parsing function ---------------------------------------*/

double masse(string elmnt) {
    XTRElement *element = [[XTRDataSource sharedInstance] elementForSymbol:@(elmnt.c_str())];
    id atomicMass = element.atomicMass;
    if (element == nil)
        return 0;
    else
        return [atomicMass doubleValue];
}

double mcalc(string aFormula) {
    /* define allowed characters for formula */
    const string UPP("ABCDEFGHIKLMNOPRSTUVWXYZ");
    const string LOW("abcdefghiklmnoprstuy");
    const string COEFF("0123456789");
    /* define some variable */
    int parentest = -1, coeff, coeff2, coeffp, SIZE;
    double masse_totale, masse_tmp = 0, masse_par = 0;
    string bloc,  coeff_txt, coeff2_txt, coeffp_txt;
    char parop = '[', parcl = ']';
    /* get and test length of formula for parsing loop */
    SIZE = aFormula.length();
    if (SIZE > 100) {
        NSLog(@"ERROR: Formula is too long !");
        return 0;
    }
    /* Check for unknown characters before parsing */
    for (int i = 0; i < SIZE; i++) {
        if (UPP.find(aFormula[i]) == string::npos
            && LOW.find(aFormula[i]) == string::npos
            && COEFF.find(aFormula[i]) == string::npos
            && aFormula[i] != parop
            && aFormula[i] != parcl) {
            NSLog(@"WARNING: character '%d' ignored", aFormula[i]);
        }
    }
    /* parse the formula */
    for (int i = 0; i < SIZE; i++) {
        /* check for opening bracket */
        if (aFormula[i] == parop) {
            parentest = 1;
            masse_par = 0;
            i++;
        }
        /* check for closing bracket */
        if (aFormula[i] == parcl)
            parentest = 0;
        /* start of symbol must be uppercase letter */
        if (UPP.find(aFormula[i]) != string::npos) {
            coeff = 1;
            coeff2 = 0;
            bloc = aFormula[i];
            /* case of 2 letters symbol */
            if (LOW.find(aFormula[i + 1]) != string::npos) {
                bloc += aFormula[i + 1];
                /* case of coefficient >1 for 2 letters symbol */
                if (COEFF.find(aFormula[i + 2]) != string::npos) {
                    coeff_txt = aFormula[i + 2];
                    coeff = string2integer(coeff_txt);
                    /* case of coefficient >9 for 2 letters symbol */
                    if (COEFF.find(aFormula[i + 3]) != string::npos) {
                        coeff_txt = aFormula[i + 3];
                        coeff = string2integer(coeff_txt);
                        coeff2_txt = aFormula[i + 2];
                        coeff2 = string2integer(coeff2_txt);
                    }
                }
            }
            /* case coefficient >1 for 1 letter symbol */
            if (COEFF.find(aFormula[i + 1]) != string::npos) {
                coeff_txt = aFormula[i + 1];
                coeff = string2integer(coeff_txt);
                /* case coefficient >9 for 1 letter symbol */
                if (COEFF.find(aFormula[i + 2]) != string::npos) {
                    coeff_txt = aFormula[i + 2];
                    coeff = string2integer(coeff_txt);
                    coeff2_txt = aFormula[i + 1];
                    coeff2 = string2integer(coeff2_txt);
                }
            }
            /* compute normally if there was no open bracket */
            if (parentest == -1)
                masse_tmp += (10 * coeff2 + coeff) * masse(bloc);
            /* if open bracket, store value temporarely in masse_par */
            if (parentest == 1)
                masse_par += (10 * coeff2 + coeff) * masse(bloc);
        }
        /* if bracket is closing, get its coefficient, multiply and add */
        if (parentest == 0) {
            if (COEFF.find(aFormula[i + 1]) != string::npos) {
                coeffp_txt = aFormula[i + 1];
                coeffp = string2integer(coeffp_txt);
                masse_tmp += coeffp * masse_par;
            }
            /* fall back on non-bracket mode parsing */
            parentest = -1;
            i++;
        }
    }
    masse_totale = masse_tmp;
    /* send back value to main.cpp */
    return(masse_totale);
}

