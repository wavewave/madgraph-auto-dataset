{-# LANGUAGE PackageImports #-}

module HEP.Automation.MadGraph.Dataset.Set20110321set1 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/nobackup/iankim/nfs/workspace/ttbar/mc_script/"
  , mg5base    = "/nobackup/iankim/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/nobackup/iankim/nfs/workspace/ttbar/mc/"
  }

processWpPhiTop :: [Char]
processWpPhiTop =  
  "\ngenerate P P > wp- t @1 \nadd process P P > wp+ t~ @2 \n"

processZpPhiTop :: [Char]
processZpPhiTop =  
  "\ngenerate P P > zput t @1 \nadd process P P > zptu t~ @2 \n"


processTripPhiTop :: [Char]
processTripPhiTop =  
  "\ngenerate P P > trip~ t~ @1 \nadd process P P > trip t @2 \n"

processSixPhiTop :: [Char]
processSixPhiTop =  
  "\ngenerate P P > six t~ @1 \nadd process P P > six~ t @2 \n"



psetup_wp_phitop :: ProcessSetup
psetup_wp_phitop = PS {  
    mversion = MadGraph4
  , model = Wp
  , process = processWpPhiTop
  , processBrief = "phit"  
  , workname   = "321WpSingle"
  }

psetup_zp_phitop :: ProcessSetup
psetup_zp_phitop = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = processZpPhiTop
  , processBrief = "phit"  
  , workname   = "321ZpSingle"
  }

psetup_trip_phitop :: ProcessSetup
psetup_trip_phitop = PS {  
    mversion = MadGraph5
  , model = Trip
  , process = processTripPhiTop
  , processBrief = "phit"  
  , workname   = "321TripSingle"
  }

psetup_six_phitop :: ProcessSetup
psetup_six_phitop = PS {  
    mversion = MadGraph5
  , model = Six
  , process = processSixPhiTop
  , processBrief = "phit"  
  , workname   = "321SixSingle"
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
psetuplist = [ psetup_wp_phitop
             , psetup_zp_phitop 
             , psetup_trip_phitop
             , psetup_six_phitop ]


--psetup_wp_phitop_semitau ]

sets :: [Int]
sets = [1 ]

wptasklist :: [WorkSetup]
wptasklist =  [ WS my_ssetup (psetup_wp_phitop) (rsetupLHC7 p num) my_csetup  
                | p <- wpparamset 
                , num <- sets     ]

zptasklist :: [WorkSetup]
zptasklist =  [ WS my_ssetup (psetup_zp_phitop) (rsetupLHC7 p num) my_csetup  
                | p <- zpparamset 
                , num <- sets     ]

triptasklist :: [WorkSetup]
triptasklist =  [ WS my_ssetup (psetup_trip_phitop) (rsetupLHC7 p num) my_csetup  
                | p <- tripparamset 
                , num <- sets     ]

sixtasklist :: [WorkSetup]
sixtasklist =  [ WS my_ssetup (psetup_six_phitop) (rsetupLHC7 p num) my_csetup  
                | p <- sixparamset 
                , num <- sets     ]


totaltasklist :: [WorkSetup]
totaltasklist = wptasklist ++ zptasklist ++ triptasklist ++ sixtasklist 



          