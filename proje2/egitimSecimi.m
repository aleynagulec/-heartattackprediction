clc; clear all; close all;
load InputA.dat

girisler= [1 3 4 5 8 14];

    B=randperm(297);
    %297'ye kadar 1x200'lük vektör oluþturuyor.
    egitimsecim = B(1:200);
    %200x1 olarak gösterimi
    egitim = egitimsecim(:);
    
    %egitimverisi için InputA'dan deðerler alýndý.
    egitimverisi=[];
    for x=1:1
        for y=1:length(egitim)
            egitimverisi=[egitimverisi; InputA(egitim(y),:)];
        end
    end
    
    %e_veriden sort_random_input'un istediði sütunlara göre veriler alýndý.
    egitim_veri = [];
    for r=1:length(girisler)
        egitim_veri = [egitim_veri egitimverisi(:,girisler(r))];
    end
   