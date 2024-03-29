setar.sim<-function(data,B, setarObject, n=200, lag=1, trend=TRUE, nthresh=0, thDelay=0, Thresh, type=c("boot", "simul", "check"), starting=NULL,  rand.gen = rnorm, innov = rand.gen(n, ...),...){
###1: 3 possibilities: 
#either simulation with given th and coefMat B
# or bootstrap of linear/setar object or raw data converted into it
###2:simulations loops


if(!missing(data)&!missing(B))
	stop("You have to provide either B or data, but not both")
if(!nthresh%in%c(0,1,2))
  stop("arg nthresh should be either 0,1 or 2")
# p<-lag
# m<-lag
type<-match.arg(type)

if(!missing(B)){
  if(type!="simul"){
    type<-"simul"
    warning("Type check or boot are only avalaible with pre-specified data. The type simul was used")}
    esp<-lag
  if(trend)
    esp<-lag+1
  if(esp*(nthresh+1)!=length(B))
    stop("Matrix B bad specified")
  y<-vector("numeric", length=n)
  if(!is.null(starting)){
    if(length(starting)==lag)
    y[seq_len(lag)]<-starting
    else
    stop("Bad specification of starting values. Should have so many values as the number of lags")
  }
  npar<-esp
  if(nthresh==1){
    BDown<-B[seq_len(npar)]
    BUp<-B[-seq_len(npar)]
  }
  if(nthresh==2){
    BDown <- B[seq_len(npar)]
    BMiddle <- B[seq_len(npar)+npar]
    BUp <- B[seq_len(npar)+2*npar]
  }
}


if(!missing(data)){
  if(nthresh==0){
    setarObject<-linear(data, m=lag, include="const")
  }
  else if (nthresh %in% c(1,2)){
    if(missing(Thresh)){
      selSet<-selectSETAR(data, nthresh=nthresh, m=lag, criterion="SSR", trace=FALSE, plot=FALSE)
      th<-selSet$bests[seq_len(nthresh)+1]
    }
    else
      th<-Thresh
    setarObject<-setar(data, nthresh=nthresh, m=lag, th=th, trace=FALSE)
   }
} 


if(!missing(setarObject)){
mod<-setarObject$model.specific
  if(inherits(setarObject,"linear")){
    B<-coef(setarObject)
    nthresh<-0
  }
  if(inherits(setarObject,"setar")){
    Thresh<-getTh(coef(setarObject))
    nthresh<-mod$nthresh
    incNames<-mod$incNames
    thDelay<-mod$thDelay
    if(incNames%in%c("none", "trend"))
      stop("Arg include = none or trend currently not implemented")
    if(incNames=="trend")
      trend<-TRUE
    TotNpar<-length(coef(setarObject))-nthresh
    B<-coef(setarObject)[seq_len(TotNpar)]
    BUp<-B[grep("H", names(B))]
    BDown<-B[grep("L", names(B))]
    if(mod$nthresh==2)
      BMiddle<-B[grep("M", names(B))]
    if(mod$restriction=="OuterSymAll"){
    BUp<-B[grep("H", names(B))]
    BMiddle<-B[grep("L", names(B))]
    BDown<-BUp
    nthresh<-2
    Thresh<-c(-Thresh, Thresh)
    }
  }
  y<-setarObject$str$x
#   m<-setarObject$str$m
#   p<-m
  lag<-setarObject$str$m
  res<-na.omit(residuals(setarObject))
  sigma<-sum(res)/length(res)
}


### Try to compute number of digits of the input series and round output correspondly
#bootstraped series should not have more digits than input: this allows
if(FALSE){
if(type=="simul")
	ndig<-4
else
	ndig<-getndp(y)
	
if(ndig>.Options$digits){
	ndig<-.Options$digits
	y<-round(y,ndig)
}

if(nthresh!=0)
	Thresh<-round(Thresh, ndig)
 }
 else
  ndig<-10

##############################
###Bootstrap
##############################
thDelay<-thDelay+1
#initial values
Yb<-vector("numeric", length=length(y))		#Delta Y term
Yb[1:lag]<-y[1:lag]

z2<-vector("numeric", length=length(y))
z2[1:lag]<-y[1:lag]
#rnorm(length(y)-lag,sd=sigma)
innova<-switch(type, "boot"=sample(res, replace=TRUE), "simul"=innov, "check"=res)
resb<-c(rep(0,lag),innova)	

if(nthresh==0){
for(i in (lag+1):length(y)){
	Yb[i]<-sum(B[1],B[-1]*Yb[i-c(1:lag)],resb[i])
	}
}


else if(nthresh==1){
	for(i in (lag+1):length(y)){
		if(round(z2[i-thDelay],ndig)<=Thresh) 
			Yb[i]<-sum(BDown[1],BDown[-1]*Yb[i-c(1:lag)],resb[i])
		else 
			Yb[i]<-sum(BUp[1],BUp[-1]*Yb[i-c(1:lag)],resb[i])
		z2[i]<-Yb[i]
		}
}

else if(nthresh==2){
	for(i in (lag+1):length(y)){
		if(round(z2[i-thDelay],ndig)<=Thresh[1]) 
			Yb[i]<-sum(BDown[1],BDown[-1]*Yb[i-c(1:lag)],resb[i])
		else if(round(z2[i-thDelay],ndig)>Thresh[2]) 
			Yb[i]<-sum(BUp[1],BUp[-1]*Yb[i-c(1:lag)],resb[i])
		else
			Yb[i]<-sum(BMiddle[1],BMiddle[-1]*Yb[i-c(1:lag)],resb[i])
		z2[i]<-Yb[i]
		}
}

if(FALSE){
	while(mean(ifelse(Yb<Thresh, 1,0))>0.05){
		cat("not enough")
		if(!missing(thVar)) 
			Recall(B=B,n=n, lag=lag, trend=trend, nthresh=nthresh, thDelay=thDelay,thVar=thVar, type="simul", starting=starting)
		else
			Recall(B=B, n=n, lag=lag, trend=trend, nthresh=nthresh, thDelay=thDelay,mTh=mTh, type="simul", starting=starting)
		y<-NULL
		
		}
}


list(B=B, serie=round(Yb,ndig))
}

if(FALSE){
library(tsDyn)
environment(setar.sim)<-environment(star)

##Simulation of a TAR with 1 threshold
sim<-setar.sim(B=c(2.9,-0.4,-0.1,-1.5, 0.2,0.3),lag=2, type="simul", nthresh=1, Thresh=2, starting=c(2.8,2.2))$serie
mean(ifelse(sim>2,1,0))	#approximation of values over the threshold

#check the result
selectSETAR(sim, m=2, criterion="SSR")
selectSETAR(sim, m=2, th=list(around=2), ngrid=20)
##Bootstrap a TAR with two threshold (three regimes)
sun<-(sqrt(sunspot.year+1)-1)*2
setar.sim(data=sun,nthresh=2, type="boot", Thresh=c(6,9))$serie

##Check the bootstrap
checkBoot<-setar.sim(data=sun,nthresh=0, type="check", Thresh=6.14)$serie
cbind(checkBoot,sun)
#prob with the digits!

###linear object
lin<-linear(sun, m=1)
checkBootL<-setar.sim(setarObject=lin, type="check")$serie
cbind(checkBootL,sun)
linear(checkBootL, m=1)
###setar object
setarSun<-setar(sun, m=2, nthresh=1)
checkBoot2<-setar.sim(setarObject=setarSun, type="check")$serie
cbind(checkBoot2,sun)
#does not work

setarSun<-setar(sun, m=3, nthresh=2)
checkBoot3<-setar.sim(setarObject=setarSun, type="check")$serie
cbind(checkBoot3,sun)
#ndig approach: works with m=2, m=3, m=4
#no ndig approach: output has then more digits than input

}
