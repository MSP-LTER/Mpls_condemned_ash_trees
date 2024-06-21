library(tabulapdf)

mprb_13thru21<-extract_tables("~/Downloads/DataRequest2023-069.pdf")
#read in a list of data on 284 pages
pgs<-mprb_13thru21[[1]]
for(i in 2:284){
  pg<-mprb_13thru21[[i]]
  if(ncol(pg)==6){ #some pages read in with an extra column that was mostly blank
    pg<-pg[,-2]
  }
  pgs<-rbind(pgs, pg)
}
ash_names<-pgs[1,]
allpgs<-as.data.frame(pgs[-1,])
names(allpgs)<-ash_names

#combining fist data request with most recent
mprb24<-read.csv("~/Downloads/ash_codemned_22-24.csv")

allpgs$`Parcel ID`<-as.numeric(allpgs$`Parcel ID`)
names(allpgs)<-names(mprb24)

all_cond_ash<-rbind(allpgs, mprb24)
write.csv(all_cond_ash,"~/Documents/all_cond_ash.csv", row.names = FALSE)
