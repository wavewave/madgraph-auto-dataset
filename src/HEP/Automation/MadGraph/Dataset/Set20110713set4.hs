module HEP.Automation.MadGraph.Dataset.Set20110713set4 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.SChanC8Vschmaltz

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processSetup :: ProcessSetup SChanC8Vschmaltz
processSetup = PS {  
    model = SChanC8Vschmaltz
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "713_SChanC8Vschmaltz_TTBar0or1J_TEV"
  }

paramSet :: [ModelParam SChanC8Vschmaltz]
paramSet = [ SChanC8VschmaltzParam { mnp = m, mphi = 100.0, ga = g, nphi= 3.0 } 
           | m <- [ 400, 420, 440 ]  
           , g <- [ 0.1,0.2..1.2 ]  ]  
           

{-

| (m,g) <-    (map (\x->(200,x)) [0.4,0.45,0.50,0.55,0.60] )
                      ++ (map (\x->(300,x)) [0.4,0.45..1.0] )
                      ++ (map (\x->(400,x)) [0.6,0.65..1.10] )
                      ++ (map (\x->(600,x)) [1.0,1.05..1.60] ) 
                      ++ (map (\x->(800,x)) [1.30,1.35..1.50] ) ] -}

--                      [ (200,0.5), (200,1.0)
--                      , (400,0.5), (400,1.0), (400,1.5), (400,2.0)
--                      , (600,0.5), (600,1.0), (600,1.5), (600,2.0), (600,2.5)
--                      , (800,0.5), (800,1.0), (800,1.5), (800,2.0), (800,2.5), (800,3.0), (800,3.5)
--                      , (1000,0.5), (1000,1.0), (1000,1.5), (1000,2.0), (1000,2.5), (1000,3.0), (1000,3.5), (1000,4.0) ] ]

sets :: [Int]
sets =  [1]

ucut :: UserCut 
ucut = UserCut { 
    uc_metcut = 15.0
  , uc_etacutlep = 2.7
  , uc_etcutlep = 18.0 
  , uc_etacutjet = 2.7
  , uc_etcutjet = 15.0 
}


eventsets :: [EventSet]
eventsets =  
  [ EventSet  processSetup 
              (RS { param = p
                  , numevent = 100000
                  , machine = TeVatron
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = MLM
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = UserCutDef ucut --  NoUserCutDef -- 
                  , pgs     = RunPGS
                  , jetalgo = Cone 0.4
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- paramSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbar_TEV_schmaltz_pgsscan"
