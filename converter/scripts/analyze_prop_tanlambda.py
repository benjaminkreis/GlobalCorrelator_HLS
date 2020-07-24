from helper import *

# configurables
testname="prop_tanlambda"
var_string = "tl tl_calo z0 tl_hw tl_calo_hw z0_hw"
tab_sizes = [8]

# tree
fname="../tests/results/test_"+testname+".txt"
t = ROOT.TTree("t","")
var_string=var_string.replace(' ',':')
t.ReadFile(fname,var_string)
#hists
h=OrderedDict()    

for ts in tab_sizes:
    # basic
    pf = ""
    cut= ""
    book(h,"tl_ref" ,80,-10,10,";tan(lambda)@tk(ref)", pf=pf)
    book(h,"tl_hw"  ,80,-10,10,";tan(lambda)@tk(HW)", pf=pf)
    book(h,"tl_calo_ref" ,80,-10,10,";tan(lambda)@calo(ref)", pf=pf)
    book(h,"tl_calo_hw"  ,80,-10,10,";tan(lambda)@calo(HW)", pf=pf)
    book(h,"z0_ref" ,70,-35,35,";z0(ref)", pf=pf)
    book(h,"z0_hw"  ,70,-35,35,";z0(HW)", pf=pf)
    # fill
    draw(t,"tl","tl_ref", pf=pf, cut=cut)
    draw(t,"tl_hw","tl_hw", pf=pf, cut=cut)
    draw(t,"tl_calo","tl_calo_ref", pf=pf, cut=cut)
    draw(t,"tl_calo_hw","tl_calo_hw", pf=pf, cut=cut)
    draw(t,"z0","z0_ref", pf=pf, cut=cut)
    draw(t,"z0_hw","z0_hw", pf=pf, cut=cut)

    # REF: 2d plots of tl, tlcalo, z0
    book2(h,"h2_z0_tl_ref" ,70,-35,35,80,-10,10,";z0(ref);tan(lambda)(ref)", pf=pf)
    draw(t,"tl:z0","h2_z0_tl_ref", pf=pf, cut=cut)
    book2(h,"h2_z0_tl_calo_ref" ,70,-35,35,80,-10,10,";z0(ref);tan(lambda)@calo(ref)", pf=pf)
    draw(t,"tl_calo:z0","h2_z0_tl_calo_ref", pf=pf, cut=cut)
    book2(h,"h2_tl_tl_calo_ref" ,80,-10,10,80,-10,10,";tan(lambda)(ref);tan(lambda)@calo(ref)", pf=pf)
    draw(t,"tl_calo:tl","h2_tl_tl_calo_ref", pf=pf, cut=cut)

    # HW: 2d plots of tl, tlcalo, z0
    book2(h,"h2_z0_tl_hw" ,70,-35,35,80,-10,10,";z0(hw);tan(lambda)(hw)", pf=pf)
    draw(t,"tl_hw:z0_hw","h2_z0_tl_hw", pf=pf, cut=cut)
    book2(h,"h2_z0_tl_calo_hw" ,70,-35,35,80,-10,10,";z0(hw);tan(lambda)@calo(hw)", pf=pf)
    draw(t,"tl_calo_hw:z0_hw","h2_z0_tl_calo_hw", pf=pf, cut=cut)
    book2(h,"h2_tl_tl_calo_hw" ,80,-10,10,80,-10,10,";tan(lambda)(hw);tan(lambda)@calo(hw)", pf=pf)
    draw(t,"tl_calo_hw:tl_hw","h2_tl_tl_calo_hw", pf=pf, cut=cut)

    # diffs
    book(h,"tl_calo_diff",80,-1,1,";tan(lambda)@calo(HW)-tan(lambda)@calo(ref)", pf=pf)
    draw(t,"tl_calo_hw-tl_calo","tl_calo_diff", pf=pf, cut=cut)
    bookp(h,"p_tl_tl_calo_diff",40,-10,10,-1,1,";tan(lambda)(ref);tan(lambda)@calo(HW)-tan(lambda)@calo(ref)", pf=pf)
    draw(t,"tl_calo_hw-tl_calo:tl","p_tl_tl_calo_diff", pf=pf, cut=cut)
    bookp(h,"p_tl_calo_tl_calo_diff",40,-10,10,-1,1,";tan(lambda)@calo(ref);tan(lambda)@calo(HW)-tan(lambda)@calo(ref)", pf=pf)
    draw(t,"tl_calo_hw-tl_calo:tl_calo","p_tl_calo_tl_calo_diff", pf=pf, cut=cut)
    bookp(h,"p_z0_tl_calo_diff",70,-35,35,-1,1,";z0(ref);tan(lambda)@calo(HW)-tan(lambda)@calo(ref)", pf=pf)
    draw(t,"tl_calo_hw-tl_calo:z0","p_z0_tl_calo_diff", pf=pf, cut=cut)

    # # profile
    # bookp(h,"p_tl_calo_diff" ,60,-10,10,-1,1,";tan(lambda)@calo(ref);tan(lambda)@calo(HW)-tan(lambda)@calo(ref)", pf=pf)
    # bookp(h,"p_z0_diff" ,60,-30,30,-1,1,";z0(ref);tan(lambda)@calo(HW)-tan(lambda)@calo(ref)", pf=pf)
    # book2(h,"h2_z0_tl_calo" ,60,-30,30,60,-10,10,";z0(ref);tan(lambda)@calo(ref)", pf=pf)
    # bookp2(h,"p2_z0_tl_calo_diff" ,60,-30,30,60,-10,10,-1,1,";z0(ref);tan(lambda)@calo(ref);tan(lambda)@calo(HW)-tan(lambda)@calo(ref)", pf=pf)

    # bookp2(h,"p2_z0_tl_tl_calo_ref" ,70,-35,35,60,-10,10,-15,15,";z0(ref);tan(lambda)(ref);tan(lambda)@calo(ref)", pf=pf)
    # draw(t,"z0:tl:tl_calo","p2_z0_tl_tl_calo_ref", pf=pf, cut=cut)

    # draw(t,"tl_calo_hw-tl_calo:tl_calo","p_tl_calo_diff", pf=pf, cut=cut)
    # draw(t,"tl_calo_hw-tl_calo:z0","p_z0_diff", pf=pf, cut=cut)
    # draw(t,"z0:tl_calo:tl_calo_hw-tl_calo","p2_z0_tl_calo_diff", pf=pf, cut=cut)
    # draw(t,"tl_calo:z0","h2_z0_tl_calo", pf=pf, cut=cut)
    
    # conversion checks
    bookp(h,"p_tanlambda_tanlambdaCalo" ,80,-8,8,-3,3,";tan(lambda)(ref);tan(lambda)@calo(ref)", pf=pf)
    bookp(h,"p_tanlambda_tanlambdaCalo_hw" ,80,-8,8,-3,3,";tan(lambda)(HW);tan(lambda)@calo(HW)", pf=pf)
    bookp(h,"p_z0_tanlambdaCalo" ,80,-30,30,-3,3,";z0(ref);tan(lambda)@calo(ref)", pf=pf)
    bookp(h,"p_z0_tanlambdaCalo_hw" ,80,-30,30,-3,3,";z0(HW);tan(lambda)@calo(HW)", pf=pf)
    draw(t,"tl_calo:tl","p_tanlambda_tanlambdaCalo", pf=pf, cut=cut)
    draw(t,"tl_calo_hw:tl_hw","p_tanlambda_tanlambdaCalo_hw", pf=pf, cut=cut)
    draw(t,"tl_calo:z0","p_z0_tanlambdaCalo", pf=pf, cut=cut)
    draw(t,"tl_calo_hw:z0_hw","p_z0_tanlambdaCalo_hw", pf=pf, cut=cut)
    
            
outname="hists/"+testname+".root"
f = ROOT.TFile(outname,"recreate")
for x in h: h[x].Write()
f.Close()
