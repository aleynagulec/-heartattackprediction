clc; clear all; close all;
load InputA.dat


A=randperm(13); %Random sayý üretirken faklý degerler gelmesini saðlar.
%%[1 13] aralýðýnda 1x6lýk rasgele dizi olusturuyoruz.
random_input = [A(1:5) 14];
    
%%giriþ degerlerini küçükten büyüðe sýralýyoruz.
sort_random_input = sort(random_input);

%degerleri alma

 X_egt=[];
%%sort_random_input deðerlerine göre InputA'dan verileri alýyoruz.
for k=1:length(sort_random_input)
     X_egt = [X_egt InputA(:,sort_random_input(k))];
end