//
#include "test.h"

void test_pt_inversion(){
    unsigned int ntrials = 100;

    float pt;
    rinv_t pt_inv_hw;
    pt_t pt_hw;

    std::ofstream outfile;
    outfile.open("../../../../tests/results/test_pt_inversion.txt");
    outfile << "pt pt_inv pt_hw pt_inv_hw" << endl;
    for(unsigned int itrial = 0; itrial< ntrials; itrial++){
        pt = 1. / urand(0.01,0.5);

        pt_inv_hw = 1./pt;
        convert_pt(pt_inv_hw, pt_hw);
        
        outfile << pt    << " " << 1./pt    << " "
                << pt_hw << " " << float(pt_inv_hw)/(PF_PT_SCALE) << "\n";
    }
    outfile.close();
}

