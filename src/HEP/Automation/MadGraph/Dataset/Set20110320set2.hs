{-# LANGUAGE PackageImports #-}

module HEP.Automation.MadGraph.Dataset.Set20110320set2 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/Users/iankim/mac/workspace/ttbar/mc_script/"
  , mg5base    = "/Users/iankim/mac/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/Users/iankim/mac/workspace/ttbar/mc/"
  }

processWpPhiTopSemiTau :: [Char]
processWpPhiTopSemiTau =  
  "\ngenerate P P > wp- t, (wp- > t~ d, (t~ > b~ w-, w- > ta- vt~)), (t > b w+, w+ > J J) @1 \nadd process P P > wp- t, (wp- > t~ d, (t~ > b~ w-, w- > J J)), (t > b w+, w+ > ta+ vt ) @2 \nadd process P P > wp+ t~, (wp+ > t d~, (t > b w+, w+ > ta+ vt)), (t~ > b~ w-, w- > J J ) @3 \nadd process P P > wp+ t~ , (wp+ > t d~, (t > b w+, w+ > J J )), (t~ > b~ w- , w- > ta- vt~ ) @4 \n"

processZpPhiTopSemiTau :: [Char]
processZpPhiTopSemiTau =  
  "\ngenerate P P > zput t, (zput > t~ u, (t~ > b~ w-, w- > ta- vt~)), (t > b w+, w+ > J J) @1 \nadd process P P > zput t, (zput > t~ u, (t~ > b~ w-, w- > J J)), (t > b w+, w+ > ta+ vt ) @2 \nadd process P P > zptu t~, (zptu > t u~, (t > b w+, w+ > ta+ vt)), (t~ > b~ w-, w- > J J ) @3 \nadd process P P > zptu t~ , (zptu > t u~, (t > b w+, w+ > J J )), (t~ > b~ w- , w- > ta- vt~ ) @4 \n"


processTripPhiTopSemiTau :: [Char]
processTripPhiTopSemiTau =  
  "\ngenerate P P > trip~ t~, (trip~ > t u, (t > b w+, w+ > ta+ vt)), (t~ > b~ w-, w- > J J) @1 \nadd process P P > trip~ t~, (trip~ > t u, (t > b w+, w+ > J J)), (t~ > b~ w-, w- > ta- vt~ ) @2 \nadd process P P > trip t, (trip > t~ u~, (t~ > b~ w-, w- > ta- vt~)), (t > b w+, w+ > J J ) @3 \nadd process P P > trip t , (trip > t~ u~, (t~ > b~ w-, w- > J J )), (t > b w+ , w+ > ta+ vt ) @4 \n"

processSixPhiTopSemiTau :: [Char]
processSixPhiTopSemiTau =  
  "\ngenerate P P > six t~, (six > t u, (t > b w+, w+ > ta+ vt)), (t~ > b~ w-, w- > J J) @1 \nadd process P P > six t~, (six > t u, (t > b w+, w+ > J J)), (t~ > b~ w-, w- > ta- vt~ ) @2 \nadd process P P > six~ t, (six~ > t~ u~, (t~ > b~ w-, w- > ta- vt~)), (t > b w+, w+ > J J ) @3 \nadd process P P > six~ t , (six~ > t~ u~, (t~ > b~ w-, w- > J J )), (t > b w+ , w+ > ta+ vt ) @4 \n"



psetup_wp_phitop_semitau :: ProcessSetup
psetup_wp_phitop_semitau = PS {  
    mversion = MadGraph4
  , model = Wp
  , process = processWpPhiTopSemiTau
  , processBrief = "phit_semitau"  
  , workname   = "320Wp1J"
  }

psetup_zp_phitop_semitau :: ProcessSetup
psetup_zp_phitop_semitau = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = processZpPhiTopSemiTau
  , processBrief = "phit_semitau"  
  , workname   = "320Zp1J"
  }

psetup_trip_phitop_semitau :: ProcessSetup
psetup_trip_phitop_semitau = PS {  
    mversion = MadGraph5
  , model = Trip
  , process = processTripPhiTopSemiTau
  , processBrief = "phit_semitau"  
  , workname   = "320Trip1J"
  }

psetup_six_phitop_semitau :: ProcessSetup
psetup_six_phitop_semitau = PS {  
    mversion = MadGraph5
  , model = Six
  , process = processSixPhiTopSemiTau
  , processBrief = "phit_semitau"  
  , workname   = "320Six1J"
  }


rsetupLHC7 :: Param -> Int -> RunSetup
rsetupLHC7 p num = RS { 
    param   = p
  , numevent = 10000
  , machine = LHC7 
  , rgrun   = Fixed
  , rgscale = 200.0 
  , match   = NoMatch
  , cut     = DefCut
  , pythia  = RunPYTHIA
  , usercut = NoUserCutDef 
  , pgs     = RunPGS
  , setnum  = num
}

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

wpparamset :: [Param]
wpparamset = [ WpParam m 1.00 | m <- [300.0,400.0,600.0] ]


zpparamset :: [Param]
zpparamset = [ ZpHParam m 1.00 | m <- [200.0, 300.0,400.0,600.0] ]

tripparamset :: [Param]
tripparamset = [ TripParam m 1.00 | m <- [200.0, 300.0,400.0,600.0] ]

sixparamset :: [Param]
sixparamset = [ SixParam m 1.00 | m <- [200.0, 300.0,400.0,600.0] ]


psetuplist :: [ProcessSetup]
psetuplist = [ psetup_zp_phitop_semitau 
             , psetup_trip_phitop_semitau
             , psetup_six_phitop_semitau ]


--psetup_wp_phitop_semitau ]

sets :: [Int]
sets = [1 ]

wptasklist :: [WorkSetup]
wptasklist =  [ WS my_ssetup (psetup_wp_phitop_semitau) (rsetupLHC7 p num) my_csetup  
                | p <- wpparamset 
                , num <- sets     ]

zptasklist :: [WorkSetup]
zptasklist =  [ WS my_ssetup (psetup_zp_phitop_semitau) (rsetupLHC7 p num) my_csetup  
                | p <- zpparamset 
                , num <- sets     ]

triptasklist :: [WorkSetup]
triptasklist =  [ WS my_ssetup (psetup_trip_phitop_semitau) (rsetupLHC7 p num) my_csetup  
                | p <- tripparamset 
                , num <- sets     ]

sixtasklist :: [WorkSetup]
sixtasklist =  [ WS my_ssetup (psetup_six_phitop_semitau) (rsetupLHC7 p num) my_csetup  
                | p <- sixparamset 
                , num <- sets     ]


totaltasklist :: [WorkSetup]
totaltasklist = wptasklist ++ zptasklist ++ triptasklist ++ sixtasklist 



          