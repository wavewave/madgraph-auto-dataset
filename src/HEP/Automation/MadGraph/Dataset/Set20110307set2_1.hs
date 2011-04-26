module HEP.Automation.MadGraph.Dataset.Set20110307set2_1 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpH

import HEP.Automation.MadGraph.Dataset.Common

ucut :: UserCut
ucut = UserCut { 
    uc_metcut    = 15.0 
  , uc_etacutlep = 1.2 
  , uc_etcutlep  = 18.0
  , uc_etacutjet = 2.5
  , uc_etcutjet  = 15.0 
} 

processTTBar0or1jet :: [Char]
processTTBar0or1jet =  
  "\ngenerate P P > t t~  QED=99 @1 \nadd process P P > t t~ J QED=99 @2 \n"

psetup_zp_ttbar01j :: ProcessSetup ZpH
psetup_zp_ttbar01j = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = processTTBar0or1jet 
  , processBrief = "ttbar01j"  
  , workname   = "307ZpH1J"
  }

zpparamset :: [ModelParam ZpH]
zpparamset = [ ZpHParam mass g | mass <- [400.0] , g <- [1.75] ] 
          

psetuplist :: [ProcessSetup ZpH]
psetuplist = [ psetup_zp_ttbar01j ]

sets :: [Int]
sets = [101,102,201,202,301,302,401,402,501,502,601,602,701,702,801,802,901,902,1001,1002]

zptasklist :: ScriptSetup -> ClusterSetup ZpH -> [WorkSetup ZpH]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zp_ttbar01j) 
       (rsetupGen p MLM (UserCutDef ucut) RunPGS 50000 num) 
       csetup  
       (WebDAVRemoteDir "mc/TeVatronTau/Zp0307Big")
  | p <- zpparamset 
  , num <- sets     ]

totaltasklist :: ScriptSetup -> ClusterSetup ZpH -> [WorkSetup ZpH]
totaltasklist = zptasklist 



          