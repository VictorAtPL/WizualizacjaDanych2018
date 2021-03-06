install.packages("ggplot2")
library(ggplot2)
source("https://install-github.me/thomasp85/patchwork")
library(patchwork)
install.packages("dplyr")
library(dplyr)

#dane (Ÿród³o: https://finanse.gazetaprawna.pl/artykuly/1397550,w-europie-trzecia-sesja-ze-zwyzkami-indeksow-na-rynkach-coraz-mocniejszy-optymizm.html)
indeks<-c("Euro Stoxx 50", "DAX", "FTSE 100", "CAC 40", "IBEX 35", "FTSE MIB")
kraj<-c("Strefa euro", "Niemcy", "W.Brytania", "Francja", "Hiszpania", "Włochy")
wartosc_notowan<-c(3204.81, 11193.99, 7166.13, 5077.28, 8995.50, 19906.81)
przyrost_procentowy<-c(0.44,0.61, 0.46, 0.41, 0.14, 0.51)
przyrost_wartosci<-0.01*przyrost_procentowy*wartosc_notowan

data<-data.frame(indeks,kraj, wartosc_notowan,przyrost_wartosci)
data$pelna_nazwa<-do.call(paste, c(data[c("kraj", "indeks")], sep = "-"))


p1<-ggplot(data, aes(x=indeks, y=wartosc_notowan, fill=pelna_nazwa))+
  geom_bar(stat="identity")+labs(x="Indeks", y="Wartość notowań (pkt.)", fill="kraj-indeks")
p1<-p1+scale_fill_brewer(palette="Dark2") +ggtitle("Wartość notowań na dzieñ 13.02.2019 godz. 9:40")
p1
#dane dodatkowe (liczba ludności)
populacja_kraju=c(340e6, 83e6, 66e6,67e6, 48.5e6, 60e6)

p2<-ggplot(data, aes(x=indeks, y=wartosc_notowan, size=populacja_kraju, colour=pelna_nazwa))+
geom_point()+scale_size_continuous(range = c(4, 12))+ ylim (2000, 21000) +
  labs(x='Indeks', y='Wartość notowań (pkt.)', colour="kraj-indeks",size="populacja kraju")
p2<-p2+scale_colour_brewer(palette="Dark2")+ggtitle("Wartość notowań uwzględniając liczebność populacji odpowiadającym im krajów")
p2

p3<-ggplot(data, aes(x=indeks, y=przyrost_wartosci, fill=pelna_nazwa, label=paste0(przyrost_procentowy,"%")))+
  geom_bar(stat="identity")+labs(x = "Indeks", y="Przyrost wartości notowań (pkt.)")+geom_text(vjust =- 1, size = 4)+
  ylim(0,110)
p3<-p3+scale_fill_brewer(palette="Dark2")+ggtitle("Wzrost wartości notowań w stosunku do dnia poprzedniego")
p3

p<-(p1+theme(legend.position = "bottom") +guides(fill = guide_legend(nrow = 1))+p3+theme(legend.position ="none"))/p2
p+theme_bw()

