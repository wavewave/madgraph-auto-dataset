module HEP.Automation.MadGraph.Dataset.Set20110406set1 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Desktop

import HEP.Automation.MadGraph.Model.ZpHFull

import qualified Data.ByteString as B

processSemiZp :: [Char]
processSemiZp =  
  "\ngenerate P P > t t~, t > b w+, (t~ > u~ zput, zput > b~ d) @1 \nadd process P P > t t~, (t > u zptu, zptu > b d~), t~ > b~ w- @2\n"

psetup_zphfull_semizp :: ProcessSetup ZpHFull
psetup_zphfull_semizp = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = processSemiZp
  , processBrief = "semizp"  
  , workname   = "406ZpH_SemiZp"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 6 }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g g 
                    | m <-[150.0] 
                    , g <- [0.5*sqrt 2] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_semizp ]

sets :: [Int]
sets = [1]

zptasklist :: [WorkSetup ZpHFull]
zptasklist =  [ WS my_ssetup (psetup_zphfull_semizp) 
                   RS { param = p
                      , numevent = 10000
                      , machine = TeVatron
                      , rgrun = Fixed
                      , rgscale = 200.0
                      , match = NoMatch
                      , cut = DefCut
                      , pythia = NoPYTHIA
                      , usercut = NoUserCutDef
                      , pgs = NoPGS
                      , setnum = num } 
                     my_csetup  
                 | p <- zpHFullParamSet , num <- sets     ]



totaltasklist :: [WorkSetup ZpHFull]
totaltasklist = zptasklist 



          