clc; clear all; close all;
load InputA.dat


A=randperm(13); %Random say� �retirken fakl� degerler gelmesini sa�lar.
%%[1 13] aral���nda 1x6l�k rasgele dizi olusturuyoruz.
random_input = [A(1:5) 14];
    
%%giri� degerlerini k���kten b�y��e s�ral�yoruz.
sort_random_input = sort(random_input);

%degerleri alma

 X_egt=[];
%%sort_random_input de�erlerine g�re InputA'dan verileri al�yoruz.
for k=1:length(sort_random_input)
     X_egt = [X_egt InputA(:,sort_random_input(k))];
end