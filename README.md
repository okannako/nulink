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
