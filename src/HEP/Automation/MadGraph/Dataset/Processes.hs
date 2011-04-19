module HEP.Automation.MadGraph.Dataset.Processes where

data Process = TTBar | TTBar0or1J | SingleTZpSemiLep | TTBarSemiZp | TZpLep | TTBarSemiZpNotFull | TTBarSemiLep
             deriving (Show, Eq)


preDefProcess :: Process -> [Char]
preDefProcess TTBar       = "\ngenerate P P > t t~ QED=99\n"
preDefProcess TTBar0or1J  = "\ngenerate P P > t t~  QED=99 @1 \nadd process P P > t t~ J QED=99 @2 \n"
preDefProcess SingleTZpSemiLep = "\ngenerate    P P > t zput  QED=99, (t > b w+ , w+ > J J ), (zput > t~ u, (t~ > b~ w-, w- > L- vl~ )) @1\nadd process P P > t zput  QED=99, (t > b w+ , w+ > L+ vl ), (zput > t~ u, (t~ > b~ w-, w- > J J    )) @2\nadd process P P > zptu t~ QED=99, (zptu > t u~, (t > b w+, w+ > L+ vl    )), (t~ > b~ w-, w- > J J ) @3\nadd process P P > zptu t~ QED=99, (zptu > t u~, (t > b w+, w+ > J J      )), (t~ > b~ w-, w- > L- vl~ ) @4\n"
preDefProcess TTBarSemiZp = "\ngenerate P P > t t~ QED=99, ( t > b w+, w+ > l+ vl ), (t~ > u~ zput, zput > b~ d ) @1 \nadd process P P > t t~ QED=99, (t > u zptu, zptu > b d~ ), (t~ > b~ w-, w- > l- vl~ ) @2 \n"
preDefProcess TZpLep      = "\ngenerate P P > t zput QED=99, zput > b~ d, ( t > b w+, w+ > l+ vl ) @1 \nadd process P P > t~ zptu QED=99, (t~ > b~ w-, w- > l- vl~ ), zptu > b d~ @2 \n"
preDefProcess TTBarSemiZpNotFull = "\ngenerate P P > t t~ QED=99, t > b w+, t~ > u~ zput @1 \nadd process P P > t t~ QED=99, t > u zptu, t~ > b~ w- @2 \n"
preDefProcess TTBarSemiLep = "\ngenerate    P P > t t~  QED=99, (t > b w+ , w+ > J J ), (t~ > b~ w-, w- > L- vl~ ) @1\nadd process P P > t zput  QED=99, (t > b w+ , w+ > L+ vl ), (t~ > b~ w-, w- > J J    ) @2\nadd process P P > t t~ QED=99, (t > b w+, w+ > L+ vl    ), (t~ > b~ w-, w- > J J ) @3\nadd process P P > t t~ QED=99, (t > b w+, w+ > J J      ), (t~ > b~ w-, w- > L- vl~ ) @4\n"







