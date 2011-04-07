module HEP.Automation.MadGraph.Dataset.Set20110405set3 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Desktop

import HEP.Physics.MSSM.SLHA
import HEP.Automation.MadGraph.Model.MSSMSLHA

import qualified Data.ByteString as B

processGluGlu :: [Char]
processGluGlu =  
  "\ngenerate P P > go go\n"

psetup_mssm_gluglu :: ProcessSetup MSSMSLHA
psetup_mssm_gluglu = PS {  
    mversion = MadGraph4
  , model = MSSMSLHA
  , process = processGluGlu
  , processBrief = "gluglug"  
  , workname   = "405MSSM"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 6 }

mssmparamset :: [FilePath] -> IO [ModelParam MSSMSLHA]
mssmparamset fps = (mapM B.readFile fps) >>= return . map (MSSMSLHAParam . SLHA)
  


psetuplist :: [ProcessSetup MSSMSLHA]
psetuplist = [ psetup_mssm_gluglu ]

sets :: [Int]
sets = [1]

mssmtasklist :: [FilePath] -> IO [WorkSetup MSSMSLHA]
mssmtasklist fps = do 
  paramset <- mssmparamset fps
  return [ WS my_ssetup (psetup_mssm_gluglu) 
              RS { param = p
                 , numevent = 10000
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
         | p <- paramset , num <- sets     ]


{-
totaltasklist :: [WorkSetup MSSMSLHA]
totaltasklist = mssmtasklist
-}


          