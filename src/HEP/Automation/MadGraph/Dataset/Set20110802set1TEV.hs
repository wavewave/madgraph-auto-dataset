module HEP.Automation.MadGraph.Dataset.Set20110802set1TEV where

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
  , process = preDefProcess TTBarSemiLep
  , processBrief = "TTBarSemiLep" 
  , workname   = "802_SChanC8Vschmaltz_TTBarSemiLep_TEV"
  }

paramSet :: [ModelParam SChanC8Vschmaltz]
paramSet = [ SChanC8VschmaltzParam { mnp = m, mphi = 100.0, ga = g, nphi = n} 
           | ( m, g, n ) <- [ (440,0.45,5) 
                            , (420,0.45,6) ] ] 


sets :: [Int]
sets =  [1]

eventsets :: [EventSet]
eventsets =  
  [ EventSet  processSetup 
              (RS { param = p
                  , numevent = 10000
                  , machine = TeVatron
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = NoMatch
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = NoUserCutDef 
                  , pgs     = RunPGS
                  , jetalgo = Cone 0.4
                  , uploadhep = UploadHEP
                  , setnum  = num 
                  })
   | p <- paramSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "misc/ttbar_TEV_schmaltz_semilep"


