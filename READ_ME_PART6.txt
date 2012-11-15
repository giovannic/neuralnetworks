We need to train the network to find the optimal technology variables we can 
possible change in doing so

----------------TOPOLOGY--------------
1)
(a) number of hidden layers  range = [1, 2] (from notes)
(b) the number of neurons in each hiden layer range = [1 - ~50] (common sensem likely to be somewhere in middle)


--------------DETAILS------------------
2)
(a)learning rate
This controlls the change rate of the weights, smaller learning rate meals smallers
steps so it is more likely to converge to an optimum, it also means it will take 
longer. smaller learning rate means the weights are altered by smaller ammounts.
Too small and it will never leave local minima, too large it will never find optimum. 

(b)(activation/transfer) function
purelin: (a.k.a Liner)
http://www.mathworks.co.uk/help/nnet/ref/purelin.html
Satlin:  (a.k.a Step)
http://www.mathworks.co.uk/help/nnet/ref/satlin.html
Satlins: (a.k.a Sign)
http://www.mathworks.co.uk/help/nnet/ref/satlins.html
Logsig: (a.k.a Sigmoid)
http://www.mathworks.co.uk/help/nnet/ref/logsig.html


(c)training function (batch training functions only!)

(c)(i) parameters for each training function.


