<p align="center">  
  <a ><img src="https://user-images.githubusercontent.com/73176377/192120292-a2d37748-1d5f-4ec9-9048-057951911801.png"
width=45%
</p>

### NuLink Ödüllü Testnet Node Sistem Gereksinimleri
 - Ubuntu 20.04
 - 4 GB RAM
 - 30 GB HDD
 - İşlemci olarak kaynak dosyalarda net bir açıklamaya yok ama önerim 2 CPU
 
### Kurulum Rehber Videosu
 - Video: https://youtu.be/F69jA9JmVR8
 - NuLink Discord: https://discord.gg/kRcXuphmpz
 
### A-) Node Kurulum Adımları
- Video ile birlikte paralel giderseniz daha rahat kurulum yaparsınız.
- Öncelikle Contabo, Hetzner, Linode, Digital Oceon gibi portların açık olduğu vps sağlayıcıları dışında kurulum yapacaksanız. Alttaki kodlarla ya da sağlayıcının kendi sitesinden 9151 portunu açmalısınız.
```
sudo ufw enable
sudo ufw allow 9151
```

1.) İlk olarak tek kodu yapıştıyoruz ve gelen uyarıda node ismimizi giriyoruz. Bazı noktalarda sizden değer girmenizi isteyecek, şifre, kelimeler gibi ve belirli çıktılar verecek. Hepsini kesinlikle bir yere kaydedin, ilerde lazım olma ihtimali çok yüksek.
 ```
wget -q -O nulink.sh https://raw.githubusercontent.com/okannako/nulink/main/nulink.sh && chmod +x nulink.sh && sudo /bin/bash nulink.sh
 ```

2.) Kurulumda bize verdiği çıktıyı (herkeste farklı) ``/root/geth-linux-amd64-1.10.24-972007XXXXX`` aşağıdaki kodda yerine yazıyoruz
```
cp /root/geth-linux-amd64-1.10.24-972007XXXXX /root/nulink
```

3.) Yetki veriyoruz.
```
chmod -R 777 /root/nulink
```

4.) Şifre ataması yapıyoruz. Lütfen tek kodu çalıştırdığımızda verdiğiniz aynı şifreyi burada SIZINSIFRE bölümüne yazın.
```
export NULINK_KEYSTORE_PASSWORD=SIZINSIFRE
export NULINK_OPERATOR_ETH_PASSWORD=SIZINSIFRE
```

5.) Kodu bir metin belgesine kopyalayıp kendimize göre düzenliyoruz. Şifre bölümünü bir önce adımda zaten halletmiştik. GIZLIANAHTARYOLU yazısını silip en başta key oluşturduğumuzda bize verdiği UTC ile başlayan satırı (UTC--2022-09-2xxxxxxxxxxxx) sonuna kadar kopyalayıp buraya yapıştıyoruz. PUBLICADRESINIZ bölümünü de siliyoruz ve key oluştururken ki bize verdiği Public adresi giriyoruz. Girdikten sonra bize kelimeler verecek bunları kaydedip gelen iki uyarıya da `y` diyerek devam ediyoruz. En sonda bizde tekrar kelimeleri girmemizi isteyecek, kaydettiğimiz kelimeleri buraya yapıştırarak işlemi bitiriyoruz. Aldığınız çıktıyı da kaydedin.
```
docker run -it --rm \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
nulink/nulink nulink ursula init \
--signer keystore:///code/GIZLIANAHTARYOLU \
--eth-provider https://data-seed-prebsc-2-s2.binance.org:8545  \
--network horus \
--payment-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--payment-network bsc_testnet \
--operator-address PUBLICADRESINIZ \
--max-gas-price 100
```

6.) Node başlatma işlemini aşağıdaki kodu girerek yapıyoruz. Daha sonra hemen log kodunu girerek logları izleyip sorun olup olmadığına bakıyoruz. Görseldeki gibi çıktılar vermeli ayrıca çıktıların içinde yer alan IP'li satırı da kaydedelim. Her şey olması gerektiği gibiyse Node işlemlerimiz burada bitti, Şimdi ikinci bölüme geçiyoruz.
```
docker run --restart on-failure -d \
--name ursula \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
-e NULINK_OPERATOR_ETH_PASSWORD \
nulink/nulink nulink ursula run --no-block-until-ready
```
```
docker logs -f ursula
```
![nulink1](https://user-images.githubusercontent.com/73176377/192327127-d7c483c0-38fb-4a58-ae28-db013a39ef7c.PNG)

### B-) Staking İşlemi Adımları
 - İlk olarak ilgili siteye bağlanıyoruz https://test-staking.nulink.org/faucet ve daha sonra ``Connect`` yaparak herhangi bir Metamask cüzdan adresimizi siteye bağlıyoruz. (Mainnetler de kullanmadığınız, testler için işlem yaptığınız bir cüzdan olsun ve hangi cüzdanla işlem yaptığınızı unutmayın.)
 - Eğer yoksa BNB Test Ağını şu siteden https://chainlist.org/ Metamaskımıza ekleyip cüzdanı o ağa geçiriyoruz (Sağ üstte Testnet butonunun açık olduğundan  emin olun). 
 - https://testnet.binance.org/faucet-smart sitesine gidip kendimizie test tokenı alıyoruz.
 - Cüzdanımıza token geldikten sonra 1. sıradaki siteden cüzdanımıza faucet alıyoruz.
 - Staking adımından miktarı max yapıp işlemi onaylıyoruz.
    ![nulink2](https://user-images.githubusercontent.com/73176377/192143295-c81f229d-63ea-4944-b0bb-2df52e8e2c14.PNG)
 - Onaydan sonra sol alttaki ``Bond Worker`` butonuna tıklayıp gelen ekranda 2. satıra key oluştururken verdiği Public adresi, 3. satıra da Node kurulumu sırasında 6. adımda kaydettiğimiz IP'li satırı girip onaylıyoruz.
   ![nulink3](https://user-images.githubusercontent.com/73176377/192143305-57850b56-b8ca-42b6-a031-976301f1e65f.PNG) 
 - Başta Offline görünür ancak bir süre sonra Online olarak görünmeli.
 - ``!DİKKAT!`` Son adım olmazsa olmaz. Bu formu ( https://forms.gle/MBzxNbJ57pEd3hh27 ) kesinlike doldurup yollamalısınız isterseniz hemen yollayın isterseniz Staking sitesi yenilendikçe denedikçe yollayın. Çünkü sizden öneri veya hata bulmanızı istiyorlar ve de bu yazdıklarınız ciddi şeyler olmalı. Önemsizce yazılmış ya da kopyala yapıştırla yorum yapıp yollanan cümleler olmalalı. Bu form yollamayanlar ödül kazanma şansını kaybedecek. Testnet bitiş tarihinden önce mutlaka yollanmalı.
 
 
 ### c-) Güncelleme

1-) Başlangıçta aşağıdaki iki kodla node durdurup docker bilgilerini temizliyoruz.
```
sudo docker kill ursula
sudo docker rm ursula
```
2-) Yeni dosyaları çekiyoruz.
```
docker pull nulink/nulink:latest
```
3-) İlk kurulumdaki belirlediğiniz şifreleri yine aynı şekilde ekleyin.
```
export NULINK_KEYSTORE_PASSWORD=SIZINSIFRE
export NULINK_OPERATOR_ETH_PASSWORD=SIZINSIFRE
```
4-) Tek kod şeklinde girip tekrar başlatıyoruz.
```
docker run --restart on-failure -d \
--name ursula \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
-e NULINK_OPERATOR_ETH_PASSWORD \
nulink/nulink nulink ursula run --no-block-until-ready
```
5-) ``docker logs -f ursula`` komutuyla kontrol ettiğinizde eğer ``is not bonded to a staking provider`` yazısı çıkıyorsa https://test-staking.nulink.org sitesine gidip unbond bond işlemi yaptığınızda sorun kalmayacaktır. Ayrıca loglarda sorun olmasa bile siteye gidip ``Online`` olarak göründüğünden ve sağ tarafta ödüllerin arttığından emin olun. Bir sorunla karşılaşırsanız https://forms.gle/MBzxNbJ57pEd3hh27 adresindeki formu doldurmayı unutmayın.

### D-) HATA
 -Eğer aşağıdaki ss'de görünen hata ile karşılaşıyorsanız Worker adresinize (en başta oluşturduğunuz) bir miktar TBNB yollayın. 2. ss'de ki gibi TX gösterip duracaktır, bu normal.
 
![hatanulink](https://user-images.githubusercontent.com/73176377/197430522-a19cd18e-be8c-451a-b151-e0bc129a356d.PNG)
![hatanulink2](https://user-images.githubusercontent.com/73176377/197430532-55a3b6b3-b063-4d66-a61e-af2ddb49aafb.PNG)

### E-) NuLink Taşıma Rehberi

 -İlk önce https://test-staking.nulink.org/ sitesinden Unbond ve Unstake işlemlerini yapıyoruz.
 -Daha sonra winscp ile node kurulu olan vps'e bağlanıp ``nulink`` ve ``geth-linux-amd64-1.10.24-972007a5`` klasörlerini yedekliyoruz.
 -Şu iki kodla eski node u durduruyoruz.
```
 sudo docker kill ursula
 sudo docker rm ursula
```
 -Sonra yeni vps'e putty vs. ile bağlanıp kurulum işlemlerini başlıyoruz. Aşağıdaki scripti kopyalayıp yapıştırıyoruz ve yüklemeninin bitmesini bekliyoruz.
```
 wget -q -O nulinktasima.sh https://raw.githubusercontent.com/okannako/nulink/main/nulinktasima.sh && chmod +x nulinktasima.sh && sudo /bin/bash nulinktasima.sh
```
 -Yükleme bittikten sonra yedeklediğimiz dosyaları winscip ile yeni vps'de root'un içine atıyoruz ve Nulink içindeki ursula.json dosyasını sağ tıklayıp siliyoruz, yoksa hata veriyor.
  -Yukarıda Node Yükleme Adımları 2'den aynı şekilde devam ediyoruz.


