!init.

+!init : button_start <- !!clean.
+!init <- !!init.

+!clean : stop  <- -stop; !!init. 
+!clean : clean <- !move; !!clean.
+!clean : dirty <- suck;  !!clean.
-!clean         <- !!clean.

+!move : pos_1 <- right.
+!move : pos_2 <- down.
+!move : pos_3 <- +stop; up.
+!move : pos_4 <- left.