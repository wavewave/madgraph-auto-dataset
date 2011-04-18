module HEP.Automation.MadGraph.Dataset.Set20110411set5 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpH

import HEP.Automation.MadGraph.Dataset.Common

processSingleTZpSemiLep = "\ngenerate    P P > zput t  QED=99, (zput > t~ u, (t~ > b~ w-, w- > J J    )), (t > b w+ , w+ > L+ vl )   @1 \nadd process P P > zput t  QED=99, (zput > t~ u, (t~ > b~ w-, w- > L- vl~ )), (t > b w+ , w+ > J J )     @2 \nadd process P P > zptu t~ QED=99, (zptu > t u~, (t > b w+, w+ > L+ vl    )), (t~ > b~ w-, w- > J J )    @3 \nadd process P P > zptu t~ QED=99, (zptu > t u~, (t > b w+, w+ > J J      )), (t~ > b~ w-, w- > L- vl~ ) @4 \n"


{- again wrong one. stupid madgraph
processSingleTZpSemiLep :: [Char]
processSingleTZpSemiLep = "\ngenerate    P P > t zput  QED=99, (t > b w+ , w+ > J J ), (zput > t~ u, (t~ > b~ w-, w- > L- vl~ )) @1\nadd process P P > t zput  QED=99, (t > b w+ , w+ > L+ vl ), (zput > t~ u, (t~ > b~ w-, w- > J J    )) @2\nadd process P P > zptu t~ QED=99, (zptu > t u~, (t > b w+, w+ > L+ vl    )), (t~ > b~ w-, w- > J J ) @3\nadd process P P > zptu t~ QED=99, (zptu > t u~, (t > b w+, w+ > J J      )), (t~ > b~ w-, w- > L- vl~ ) @4\n"
-}

{- Wrong one.
  "\ngenerate    P P > t zput  QED=99, (zput > t~ u, (t~ > b~ w-, w- > L- vl~ )), (t > b w+ , w+ > J J ) @1 \nadd process P P > t zput  QED=99, (zput > t~ u, (t~ > b~ w-, w- > J J    )), (t > b w+ , w+ > L+ vl ) @2 \nadd process P P > zptu t~ QED=99, (zptu > t u~, (t > b w+, w+ > L+ vl    )), (t~ > b~ w-, w- > J J ) @3 \nadd process P P > zptu t~ QED=99, (zptu > t u~, (t > b w+, w+ > J J      )), (t~ > b~ w-, w- > L- vl~ ) @4 \n" -}

psetup_zp_SingleTZpSemiLep :: ProcessSetup ZpH
psetup_zp_SingleTZpSemiLep = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = processSingleTZpSemiLep
  , processBrief = "SingleTZpSemiLep"  
  , workname   = "412_ZpH_SingleTZpSemiLep"
  }

zpparamset :: [ModelParam ZpH]
zpparamset = [ ZpHParam mass g | mass <- [400.0] , g <- [1.75] ] 
          

psetuplist :: [ProcessSetup ZpH]
psetuplist = [ psetup_zp_SingleTZpSemiLep ]

sets :: [Int]
sets = [1,2,3,4,5] 

zptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpH]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zp_SingleTZpSemiLep) 
       (rsetupLHC p NoMatch  NoUserCutDef RunPGS 10000 num) 
       csetup  
       (WebDAVRemoteDir "mc/LHC7New/Zp0412SingleTZpSemiLep")
  | p <- zpparamset 
  , num <- sets     ]

totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpH]
totaltasklist = zptasklist 



          