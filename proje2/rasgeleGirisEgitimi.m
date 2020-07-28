Best_cost=100;
Best_fis=[];
sayac=0;

for i=1:1
    epoch_n = 1;
    in_fismat=genfis1(X_egt,3,'gaussmf');
%     [x1,mf1] = plotmf(in_fismat,'input',1);
%     subplot(5,2,1),plot(x1,mf1);
%     title('EÐÝTÝM ÝÇÝN SONUÇLAR');
%     [x2,mf2] = plotmf(in_fismat,'input',2);
%     subplot(5,2,3),plot(x2,mf2);
%     [x3,mf3] = plotmf(in_fismat,'input',3);
%     subplot(5,2,5),plot(x3,mf3);
%     [x4,mf4] = plotmf(in_fismat,'input',4);
%     subplot(5,2,7),plot(x4,mf4);
%     [x5,mf5] = plotmf(in_fismat,'input',5);
%     subplot(5,2,9),plot(x5,mf5);
    
    out_fismat = anfis(X_egt,in_fismat,epoch_n)
%     [x1son,mf1son] = plotmf(out_fismat,'input',1);%Bu þekilde bütün giriþleri çizdirebilirsin.
%     subplot(5,2,2),plot(x1son,mf1son);
%     title('TEST ÝÇÝN SONUÇLAR');
%     [x2son,mf2son] = plotmf(out_fismat,'input',2);
%     subplot(5,2,4),plot(x2son,mf2son);
%     [x3son,mf3son] = plotmf(out_fismat,'input',3);
%     subplot(5,2,6),plot(x3son,mf3son);
%     [x4son,mf4son] = plotmf(out_fismat,'input',4);
%     subplot(5,2,8),plot(x4son,mf4son);
%     [x5son,mf5son] = plotmf(out_fismat,'input',5);
%     subplot(5,2,10),plot(x5son,mf5son);
%     f=figure(); 
    
    deger = evalfis(X_egt(:,1:5),out_fismat);
    
    plot(X_egt(:,6),deger,'rs'); %performance in terms of cross plotting 

    pause(0.01);

    hata=X_egt(:,6)-deger;
    cost=sqrt(mse(hata));
    if cost<Best_cost Best_cost=cost; Best_fis=out_fismat; end
    sayac=sayac+1
    
end

%%deger'in 0 1 2 3 4 toplamlarý
    sifir=0; bir=0; iki=0; uc=0; dort=0;
    for z=1:length(deger)
        if deger(z)>-1 && deger(z)<1
            sifir=sifir+1;
        elseif deger(z)>0 && deger(z)<2
            bir=bir+1;
        elseif deger(z)>1 && deger(z)<3
            iki=iki+1;
        elseif deger(z)>2 && deger(z)<4
            uc=uc+1;
        elseif deger(z)>3 && deger(z)<5
            dort=dort+1;
        end
    end
    
    deger = evalfis(X_egt(:,1:5),Best_fis);

    
    %%tolerans aralýðý
    for c=1:1
        for d=1:297  %%deger aralýgýna göre burayý deðiþtirmeyi unutma.
            if (-0.25<deger(d)) && (deger(d)<=0.25)
                deger(d)=0;
            elseif  (0.75<deger(d)) && (deger(d)<=1.25)
                deger(d)=1;
            elseif  (1.75<deger(d)) && (deger(d)<=2.25)
                deger(d)=2; 
            elseif  (2.75<deger(d)) && (deger(d)<=3.25)
                deger(d)=3;
            elseif  (3.75<deger(d)) && (deger(d)<=4.25)
                deger(d)=4;
            end
        end
    end
     %%testveri'nin cýkýsýndaki degerlere göre toplamlar
    egt_son=X_egt(:,6);
    xsifir=0; xbir=0; xiki=0; xuc=0; xdort=0;
    for y=1:length(egt_son)
        if egt_son(y)>-1 && egt_son(y)<1
            xsifir=xsifir+1;
        elseif egt_son(y)>0 && egt_son(y)<2
            xbir=xbir+1;
        elseif egt_son(y)>1 && egt_son(y)<3
            xiki=xiki+1;
        elseif egt_son(y)>2 && egt_son(y)<4
            xuc=xuc+1;
        elseif egt_son(y)>3 && egt_son(y)<5
            xdort=xdort+1;
        end
    end
   
    %%test icin doðru-yanlis sayilari
    xsifirDogru = sifir;
    xsifirYanlis = abs(xsifir-sifir);
    
    xbirDogru = bir;
    xbirYanlis = abs(bir-xbir);
    
    xikiDogru = iki;
    xikiYanlis = abs(iki-xiki);
    
    xucDogru = uc;
    xucYanlis = abs(uc-xuc);
    
    xdortDogru = dort;
    xdortYanlis = abs(dort-xdort);
  
    xDogruYanlis2 = [
        0 xsifirDogru xsifirYanlis;
        1 xbirDogru xbirYanlis;
        2 xikiDogru xikiYanlis;
        3 xucDogru xucYanlis;
        4 xdortDogru xdortYanlis];

      %C_egt için doðruluk hesabý (accuracy cal.)
    acc_cal0_x=100*xDogruYanlis2(1,2)/(xDogruYanlis2(1,2)+xDogruYanlis2(1,3));
    acc_cal1_x=100*xDogruYanlis2(2,2)/(xDogruYanlis2(2,2)+xDogruYanlis2(2,3));
    acc_cal2_x=100*xDogruYanlis2(3,2)/(xDogruYanlis2(3,2)+xDogruYanlis2(3,3));
    acc_cal3_x=100*xDogruYanlis2(4,2)/(xDogruYanlis2(4,2)+xDogruYanlis2(4,3));
    acc_cal4_x=100*xDogruYanlis2(5,2)/(xDogruYanlis2(5,2)+xDogruYanlis2(5,3));
    
    xDogruYanlis = [string('Kalp Krizi') string('Doðru Sayýsý') string('Yanlýþ Sayýsý') string('Doðruluk Hesabý');
        0 xsifirDogru xsifirYanlis acc_cal0_x;
        1 xbirDogru xbirYanlis acc_cal1_x;
        2 xikiDogru xikiYanlis acc_cal2_x;
        3 xucDogru xucYanlis acc_cal3_x;
        4 xdortDogru xdortYanlis acc_cal4_x];