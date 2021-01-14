#include <cstdio>
#include "firmware/linpuppi.h"
#include "linpuppi_ref.h"
#include "../utils/DiscretePFInputsReader.h"
#include "../utils/pattern_serializer.h"
#include "../utils/test_utils.h"
#include "puppi_checker.h"

#define NTEST 500


int main() {
#if defined(REG_HGCalNoTK)
    //DiscretePFInputsReader inputs("TTbar_PU200_HGCalNoTK.dump");
    DiscretePFInputsReader inputs("VBFHToBB_PU200_HGCalNoTK.dump");
#elif defined(REG_HF)
    DiscretePFInputsReader inputs("VBFHToBB_PU200_HF.dump");
#endif

    linpuppi_config cfg(NTRACK, NCALO, NNEUTRALS,
                        LINPUPPI_DR2MIN, LINPUPPI_DR2MAX, LINPUPPI_ptMax, LINPUPPI_dzCut,
                        LINPUPPI_ptSlopeNe, LINPUPPI_ptSlopePh, LINPUPPI_ptZeroNe, LINPUPPI_ptZeroPh, 
                        LINPUPPI_alphaSlope, LINPUPPI_alphaZero, LINPUPPI_alphaCrop, 
                        LINPUPPI_priorNe, LINPUPPI_priorPh,
                        LINPUPPI_ptCut);
    
    // input TP objects (used)
    HadCaloObj calo[NCALO];

    // input TP objects (unused, but needed to read the inputs)
    EmCaloObj emcalo[NEMCALO]; TkObj track[NTRACK]; MuObj mu[NMU]; z0_t hwZPV;

    // input/output PFPUPPI objects
    PuppiObj outselne[NNEUTRALS];
    PuppiObj outselne_ref[NNEUTRALS];
    PuppiObj outselne_flt[NNEUTRALS];
    PuppiObj outallne[NCALO];
    PuppiObj outallne_ref_nocut[NCALO], outallne_ref[NCALO];
    PuppiObj outallne_flt_nocut[NCALO], outallne_flt[NCALO];

#if defined(PACKING_DATA_SIZE) && defined(PACKING_NCHANN)
    PatternSerializer serPatternsIn("fwlinpuppi_input_patterns.txt"), serPatternsOut("fwlinpuppi_output_patterns.txt");
    ap_uint<PACKING_DATA_SIZE> packed_input[PACKING_NCHANN], packed_output[PACKING_NCHANN];
    for (unsigned int i = 0; i < PACKING_NCHANN; ++i) { packed_input[i] = 0; packed_output[i] = 0; }
#endif

    PuppiChecker checker;

    for (int test = 1; test <= NTEST; ++test) {
        // get the inputs from the input object
        if (!inputs.nextRegion(calo, emcalo, track, mu, hwZPV)) break;

#ifdef TEST_PT_CUT
        float minpt = 0;
        for (unsigned int i = 0; i < NCALO; ++i) minpt += calo[i].hwPt*LINPUPPI_ptLSB;
        if (minpt < TEST_PT_CUT) { 
            //std::cout << "Skipping region with total calo pt " << minpt << " below threshold." << std::endl; 
            --test; continue; 
        }
#endif

        bool verbose = 0;
        if (verbose) printf("test case %d\n", test);
        linpuppi_set_debug(verbose);

#if defined(PACKING_DATA_SIZE) && defined(PACKING_NCHANN)
        l1pf_pattern_pack<NCALO,0>(calo, packed_input);
        serPatternsIn(packed_input);
  #if defined(TEST_PUPPI_NOCROP)
        packed_fwdlinpuppiNoCrop(packed_input, packed_output);
        l1pf_pattern_unpack<NCALO,0>(packed_output, outallne);
  #else
        packed_fwdlinpuppi(packed_input, packed_output);
        l1pf_pattern_unpack<NNEUTRALS,0>(packed_output, outselne);
  #endif
        serPatternsOut(packed_output);
#else
  #if defined(TEST_PUPPI_NOCROP)
        fwdlinpuppiNoCrop(calo, outallne);
  #else
        fwdlinpuppi(calo, outselne);
  #endif
#endif

        fwdlinpuppi_ref(cfg, calo, outallne_ref_nocut, outallne_ref, outselne_ref, verbose);
        fwdlinpuppi_flt(cfg, calo, outallne_flt_nocut, outallne_flt, outselne_flt, verbose);

        // validate numerical accuracy 
        checker.checkIntVsFloat<HadCaloObj,NCALO>(calo, outallne_ref_nocut, outallne_flt_nocut, verbose);

        // check vs reference
#if defined(TEST_PUPPI_NOCROP)
        bool ok = checker.check<NCALO>(outallne, outallne_ref, outallne_flt);
#else
        bool ok = checker.check<NSELCALO>(outselne, outselne_ref, outselne_flt);
#endif
        if (!ok) {
            printf("FAILED test %d\n", test);
            HumanReadablePatternSerializer dumper("-", true);
            dumper.dump_puppi(NCALO, "    ", outallne);
            dumper.dump_puppi(NCALO, "ref ", outallne_ref);
            dumper.dump_puppi(NCALO, "rnc ", outallne_ref_nocut);
            dumper.dump_puppi(NCALO, "flt ", outallne_flt_nocut);
            return 1;
        }

        if (verbose) printf("\n");
        else         printf("passed test %d\n", test);

    }

    printf("Report for %d regions (cropped at NCALO=%d):\n", NTEST, NCALO);
    checker.printIntVsFloatReport();
    return 0;
}