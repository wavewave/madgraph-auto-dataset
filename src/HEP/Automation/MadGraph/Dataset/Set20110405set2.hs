module HEP.Automation.MadGraph.Dataset.Set20110405set2 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.SUSY

import HEP.Automation.MadGraph.Model.WpZpFull

processTB :: [Char]
processTB =  
  "\ngenerate P P > t b / g a z h w+ w-  QED=99 @1\nadd process P P > t~ b~ / g a z h w+ w- QED=99 @2\n"

psetup_wpzpfull_bb :: ProcessSetup WpZpFull
psetup_wpzpfull_bb = PS {  
    mversion = MadGraph4
  , model = WpZpFull
  , process = processTB 
  , processBrief = "tb"  
  , workname   = "405WpZpFull"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

wpzpparamset :: [ModelParam WpZpFull]
wpzpparamset = [ WpZpFullParam m m gW gW gZ gZ gZ gZ 
                    | m <-[150.0] 
                    , gW <- [0.5*sqrt 2] 
                    , gZ <- [0.5]  ] 
          

psetuplist :: [ProcessSetup WpZpFull]
psetuplist = [ psetup_wpzpfull_bb ]

sets :: [Int]
sets = [1]

wpzptasklist2 :: [WorkSetup WpZpFull]
wpzptasklist2 =  [ WS my_ssetup (psetup_wpzpfull_bb) 
                      RS { param = p
                         , numevent = 20000
                         , machine = LHC7
                         , rgrun = Fixed
                         , rgscale = 200.0
                         , match = NoMatch
                         , cut = DefCut
                         , pythia = NoPYTHIA
                         , usercut = NoUserCutDef
                         , pgs = NoPGS
                         , setnum = num } 
                      my_csetup  
                 | p <- wpzpparamset , num <- sets     ]



totaltasklist :: [WorkSetup WpZpFull]
totaltasklist = wpzptasklist2 



          