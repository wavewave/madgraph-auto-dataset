{-# LANGUAGE PackageImports #-}

module HEP.Automation.MadGraph.Dataset.Set20110321set2 where


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

processWpPhiPhi :: [Char]
processWpPhiPhi =  
  "\ngenerate P P > wp+ wp- QED=99 \n"

processZpPhiPhi :: [Char]
processZpPhiPhi =  
  "\ngenerate P P > zput zptu QED=99 \n"


processTripPhiPhi :: [Char]
processTripPhiPhi =  
  "\ngenerate P P > trip trip~ QED=99 \n"

processSixPhiPhi :: [Char]
processSixPhiPhi =  
  "\ngenerate P P > six six~ QED=99 \n"



psetup_wp_phiphi :: ProcessSetup
psetup_wp_phiphi = PS {  
    mversion = MadGraph4
  , model = Wp
  , process = processWpPhiPhi
  , processBrief = "phiphi"  
  , workname   = "321WpDouble"
  }

psetup_zp_phiphi :: ProcessSetup
psetup_zp_phiphi = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = processZpPhiPhi
  , processBrief = "phiphi"  
  , workname   = "321ZpDouble"
  }

psetup_trip_phiphi :: ProcessSetup
psetup_trip_phiphi = PS {  
    mversion = MadGraph5
  , model = Trip
  , process = processTripPhiPhi
  , processBrief = "phiphi"  
  , workname   = "321TripDouble"
  }

psetup_six_phiphi :: ProcessSetup
psetup_six_phiphi = PS {  
    mversion = MadGraph5
  , model = Six
  , process = processSixPhiPhi
  , processBrief = "phiphi"  
  , workname   = "321SixDouble"
  }


rsetupLHC7 :: Param -> Int -> RunSetup
rsetupLHC7 p num = RS { 
    param   = p
  , numevent = 10000
  , machine = LHC7 
  , rgrun   = Fixed
  , rgscale = 200.0 
  , match   = NoMatch
  , cut     = NoCut
  , pythia  = NoPYTHIA
  , usercut = NoUserCutDef 
  , pgs     = NoPGS
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
psetuplist = [ psetup_wp_phiphi
             , psetup_zp_phiphi 
             , psetup_trip_phiphi
             , psetup_six_phiphi ]


--psetup_wp_phitop_semitau ]

sets :: [Int]
sets = [1 ]

wptasklist :: [WorkSetup]
wptasklist =  [ WS my_ssetup (psetup_wp_phiphi) (rsetupLHC7 p num) my_csetup  
                | p <- wpparamset 
                , num <- sets     ]

zptasklist :: [WorkSetup]
zptasklist =  [ WS my_ssetup (psetup_zp_phiphi) (rsetupLHC7 p num) my_csetup  
                | p <- zpparamset 
                , num <- sets     ]

triptasklist :: [WorkSetup]
triptasklist =  [ WS my_ssetup (psetup_trip_phiphi) (rsetupLHC7 p num) my_csetup  
                | p <- tripparamset 
                , num <- sets     ]

sixtasklist :: [WorkSetup]
sixtasklist =  [ WS my_ssetup (psetup_six_phiphi) (rsetupLHC7 p num) my_csetup  
                | p <- sixparamset 
                , num <- sets     ]


totaltasklist :: [WorkSetup]
totaltasklist = wptasklist ++ zptasklist ++ triptasklist ++ sixtasklist 



          