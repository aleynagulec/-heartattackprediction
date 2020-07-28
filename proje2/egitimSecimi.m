clc; clear all; close all;
load InputA.dat

girisler= [1 3 4 5 8 14];

    B=randperm(297);
    %297'ye kadar 1x200'l�k vekt�r olu�turuyor.
    egitimsecim = B(1:200);
    %200x1 olarak g�sterimi
    egitim = egitimsecim(:);
    
    %egitimverisi i�in InputA'dan de�erler al�nd�.
    egitimverisi=[];
    for x=1:1
        for y=1:length(egitim)
            egitimverisi=[egitimverisi; InputA(egitim(y),:)];
        end
    end
    
    %e_veriden sort_random_input'un istedi�i s�tunlara g�re veriler al�nd�.
    egitim_veri = [];
    for r=1:length(girisler)
        egitim_veri = [egitim_veri egitimverisi(:,girisler(r))];
    end
   