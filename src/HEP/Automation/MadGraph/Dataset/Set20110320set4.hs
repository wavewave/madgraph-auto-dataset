{-# LANGUAGE PackageImports #-}

module HEP.Automation.MadGraph.Dataset.Set20110320set4 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/nobackup/iankim/nfs/workspace/ttbar/mc_script2/"
  , mg5base    = "/nobackup/iankim/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/nobackup/iankim/nfs/workspace/ttbar/mc/"
  }

processWpPhiTopSemiLep :: [Char]
processWpPhiTopSemiLep =  
  "\ngenerate P P > wp- t, (wp- > t~ d, (t~ > b~ w-, w- > L- vl~)), (t > b w+, w+ > J J) @1 \nadd process P P > wp- t, (wp- > t~ d, (t~ > b~ w-, w- > J J)), (t > b w+, w+ > L+ vl ) @2 \nadd process P P > wp+ t~, (wp+ > t d~, (t > b w+, w+ > L+ vl)), (t~ > b~ w-, w- > J J ) @3 \nadd process P P > wp+ t~ , (wp+ > t d~, (t > b w+, w+ > J J )), (t~ > b~ w- , w- > L- vl~ ) @4 \n"

processZpPhiTopSemiLep :: [Char]
processZpPhiTopSemiLep =  
  "\ngenerate P P > zput t, (zput > t~ u, (t~ > b~ w-, w- > L- vl~)), (t > b w+, w+ > J J) @1 \nadd process P P > zput t, (zput > t~ u, (t~ > b~ w-, w- > J J)), (t > b w+, w+ > L+ vl ) @2 \nadd process P P > zptu t~, (zptu > t u~, (t > b w+, w+ > L+ vl)), (t~ > b~ w-, w- > J J ) @3 \nadd process P P > zptu t~ , (zptu > t u~, (t > b w+, w+ > J J )), (t~ > b~ w- , w- > L- vl~ ) @4 \n"


processTripPhiTopSemiLep :: [Char]
processTripPhiTopSemiLep =  
  "\ngenerate P P > trip~ t~, (trip~ > t u, (t > b w+, w+ > L+ vl)), (t~ > b~ w-, w- > J J) @1 \nadd process P P > trip~ t~, (trip~ > t u, (t > b w+, w+ > J J)), (t~ > b~ w-, w- > L- vl~ ) @2 \nadd process P P > trip t, (trip > t~ u~, (t~ > b~ w-, w- > L- vl~)), (t > b w+, w+ > J J ) @3 \nadd process P P > trip t , (trip > t~ u~, (t~ > b~ w-, w- > J J )), (t > b w+ , w+ > L+ vl ) @4 \n"

processSixPhiTopSemiLep :: [Char]
processSixPhiTopSemiLep =  
  "\ngenerate P P > six t~, (six > t u, (t > b w+, w+ > L+ vl)), (t~ > b~ w-, w- > J J) @1 \nadd process P P > six t~, (six > t u, (t > b w+, w+ > J J)), (t~ > b~ w-, w- > L- vl~ ) @2 \nadd process P P > six~ t, (six~ > t~ u~, (t~ > b~ w-, w- > L- vl~)), (t > b w+, w+ > J J ) @3 \nadd process P P > six~ t , (six~ > t~ u~, (t~ > b~ w-, w- > J J )), (t > b w+ , w+ > L+ vl ) @4 \n"



psetup_wp_phitop_semilep :: ProcessSetup
psetup_wp_phitop_semilep = PS {  
    mversion = MadGraph4
  , model = Wp
  , process = processWpPhiTopSemiLep
  , processBrief = "phit_semilep"  
  , workname   = "321Wp1JSL"
  }

psetup_zp_phitop_semilep :: ProcessSetup
psetup_zp_phitop_semilep = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = processZpPhiTopSemiLep
  , processBrief = "phit_semilep"  
  , workname   = "321Zp1JSL"
  }

psetup_trip_phitop_semilep :: ProcessSetup
psetup_trip_phitop_semilep = PS {  
    mversion = MadGraph5
  , model = Trip
  , process = processTripPhiTopSemiLep
  , processBrief = "phit_semilep"  
  , workname   = "321Trip1JSL"
  }

psetup_six_phitop_semilep :: ProcessSetup
psetup_six_phitop_semilep = PS {  
    mversion = MadGraph5
  , model = Six
  , process = processSixPhiTopSemiLep
  , processBrief = "phit_semilep"  
  , workname   = "321Six1JSL"
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
my_csetup = CS { cluster = Parallel 8 }

wpparamset :: [Param]
wpparamset = [ WpParam m 1.00 | m <- [200.0, 300.0,400.0,600.0] ]


zpparamset :: [Param]
zpparamset = [ ZpHParam m 1.00 | m <- [200.0, 300.0,400.0,600.0] ]

tripparamset :: [Param]
tripparamset = [ TripParam m 1.00 | m <- [200.0, 300.0,400.0,600.0] ]

sixparamset :: [Param]
sixparamset = [ SixParam m 1.00 | m <- [200.0, 300.0,400.0,600.0] ]


psetuplist :: [ProcessSetup]
psetuplist = [ psetup_wp_phitop_semilep 
             , psetup_zp_phitop_semilep 
             , psetup_trip_phitop_semilep
             , psetup_six_phitop_semilep ]




sets :: [Int]
sets = [1 ]

wptasklist :: [WorkSetup]
wptasklist =  [ WS my_ssetup (psetup_wp_phitop_semilep) (rsetupLHC7 p num) my_csetup  
                | p <- wpparamset 
                , num <- sets     ]

zptasklist :: [WorkSetup]
zptasklist =  [ WS my_ssetup (psetup_zp_phitop_semilep) (rsetupLHC7 p num) my_csetup  
                | p <- zpparamset 
                , num <- sets     ]

triptasklist :: [WorkSetup]
triptasklist =  [ WS my_ssetup (psetup_trip_phitop_semilep) (rsetupLHC7 p num) my_csetup  
                | p <- tripparamset 
                , num <- sets     ]

sixtasklist :: [WorkSetup]
sixtasklist =  [ WS my_ssetup (psetup_six_phitop_semilep) (rsetupLHC7 p num) my_csetup  
                | p <- sixparamset 
                , num <- sets     ]


totaltasklist :: [WorkSetup]
totaltasklist = wptasklist ++ zptasklist ++ triptasklist ++ sixtasklist 



          