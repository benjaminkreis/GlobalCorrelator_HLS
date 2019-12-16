#include <cstdio>
#include "firmware/pfalgo2hgc.h"
#include "pfalgo2hgc_ref.h"
#include "utils/DiscretePFInputsReader.h"
#include "utils/pattern_serializer.h"
#include "utils/test_utils.h"

#define NTEST 1000


int main() {
    HumanReadablePatternSerializer debugHR("-"); // this will print on stdout, we'll use it for errors

    DiscretePFInputsReader inputs("TTbar_PU200_HGCal.dump");
    
    // input TP objects
    HadCaloObj calo[NCALO]; EmCaloObj emcalo[NEMCALO]; TkObj track[NTRACK]; z0_t hwZPV;
    MuObj mu[NMU];

    // output PF objects
    PFChargedObj outch[NTRACK], outch_ref[NTRACK];
    PFNeutralObj outne[NSELCALO], outne_ref[NSELCALO];
    PFChargedObj outmupf[NMU], outmupf_ref[NMU];

    pfalgo_config cfg(NTRACK,NCALO,NMU, NSELCALO,
                      PFALGO_DR2MAX_TK_MU, PFALGO_DR2MAX_TK_CALO,
                      PFALGO_TK_MAXINVPT_LOOSE, PFALGO_TK_MAXINVPT_TIGHT);

    // -----------------------------------------
    // run multiple tests
    for (int test = 1; test <= NTEST; ++test) {
        // get the inputs from the input object
        if (!inputs.nextRegion(calo, emcalo, track, mu, hwZPV)) break;

        pfalgo2hgc(calo, track, mu, outch, outne, outmupf);
        pfalgo2hgc_ref(cfg, calo, track, mu, outch_ref, outne_ref, outmupf_ref);

        // -----------------------------------------
        // validation against the reference algorithm
        int errors = 0; int ntot = 0, nch = 0, nneu = 0, nmu = 0;

        // check charged hadrons
        for (int i = 0; i < NTRACK; ++i) {
            if (!pf_equals(outch_ref[i], outch[i], "PF Charged", i)) errors++;
            if (outch_ref[i].hwPt > 0) { ntot++; nch++; }
        }
        for (int i = 0; i < NSELCALO; ++i) {
            if (!pf_equals(outne_ref[i], outne[i], "PF Neutral", i)) errors++;
            if (outne_ref[i].hwPt > 0) { ntot++; nneu++; }
        }
        for (int i = 0; i < NMU; ++i) {
            if (!pf_equals(outmupf_ref[i], outmupf[i], "PF Muon", i)) errors++;
            if (outmupf_ref[i].hwPt > 0) { ntot++; nmu++; }
        }        

        if (errors != 0) {
            printf("Error in computing test %d (%d)\n", test, errors);
            printf("Inputs: \n"); debugHR.dump_inputs(calo, track, mu);
            printf("Reference output: \n"); debugHR.dump_outputs(outch_ref, outne_ref, outmupf_ref);
            printf("Current output: \n"); debugHR.dump_outputs(outch, outne, outmupf);
            return 1;
        } else {
            printf("Passed test %d (%d, %d, %d)\n", test, ntot, nch, nneu);
        }

    }
    return 0;
}