library(astrochron)

dt=read()
dt_mw=mwStats(dt, win=NULL, output=T,genplot=T)
View(dt_mw)

dt_int=linterp(dt_mw, dt=100, start=NULL, genplot=T)
writeCSV("/Users/apple/Documents/moving_ave/glacier/name.csv",dt_int)
