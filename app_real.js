App = {
    web3Provider: null,
    contracts: {},
      
    init: function() {
        $.getJSON('./real-estate.json', function (data) {
            var list = $('#list');
            var template = $('#template');
            //json 데이터를 template에 출력해준다.
            for (i = 0; i < data.length; i++) {
              template.find('img').attr('src', data[i].picture);
              template.find('.id').text(data[i].id);
              template.find('.type').text(data[i].type);
              template.find('.area').text(data[i].area);
              template.find('.price').text(data[i].price);
      
              list.append(template.html());
            }
          })
      
    },
  
    initWeb3: function() {
      //metamask 설치여부 체크함
        if (typeof web3 !== 'undefined') {
        App.web3Provider = web3.currentProvider;
        web3 = new Web3(App.web3Provider);
            console.log('meta');
      } else {
        App.web3Provider = new web3.providers.HttpProvider('http://localhost:8545');
        web3 = new Web3(App.web3Provider);
            console.log("ganache");
      }
      return App.initContract();
    },
  
    initContract: function() {
        $.getJSON('realEstate.json', function (data) {
            App.contracts.RealEstate = TruffleContract(data);
            App.contracts.RealEstate.setProvider(App.web3Provider);
            console.log('RealEstate :', App.contracts.RealEstate);
            //return App.loadRealEstates();
            return App.listenToEvents();
        });   
    },
  
    buyRealEstate: function() {	
      var id = $('#id').val();
      var name = $('#name').val();
      var price = $('#price').val();
      var age = $('#age').val();

      $('#name').val('');
      $('#age').val('');
      web3.eth.getAccounts(function (error, accounts) {
        if (error) { console.log(error); }
        //현재 연결된 첫번째 계정(선택된 계정)을  account 변수에 저장한다. 
        var account = accounts[0];
        App.contracts.RealEstate.deployed().then(function (instance) {
          //매입자 이름 name 한글 인코딩 utf8.js 사용
          var nameUtf8Encoded = utf8.encode(name);
          //encoding 된 값을 hexa 값으로 변환함
          return instance.buyRealEstate(id, web3.toHex(nameUtf8Encoded), age,
            { from: account, value: price })
            .then(function () {
              //입력필드 초기화
              $('#name').val('');
              $('#age').val('');
              //Modal 사라지게
              $('#buyModal').modal('hide');
              //return App.loadRealEstates();
            }).catch(function (err) {
              console.log(err.message);
            })
        });
      })  
    },
  
    loadRealEstates: function() {
      App.contracts.RealEstate.deployed().then(function (instance) {
        return instance.getAllBuyers.call();
      }).then(function (buyers) {	
       for (i = 0; i < buyers.length; i++){
          if (buyers[i] !== '0x0000000000000000000000000000000000000000') {
            var imgType = $('.panel-realEstate').eq(i).find('img').attr('src').substr(7);
            switch (imgType) {
              case 'apartment.jpg': $('.panel-realEstate').eq(i).find('img').attr('src', 'images/apartment_sold.jpg')
                 break;
              case 'townhouse.jpg': $('.panel-realEstate').eq(i).find('img').attr('src', 'images/townhouse_sold.jpg')
                 break;
              case 'house.jpg': $('.panel-realEstate').eq(i).find('img').attr('src', 'images/house_sold.jpg')
                break;
            }//switch
            $('.panel-realEstate').eq(i).find('.btn-buy').text('매각').attr('disabled', true);
            $('.panel-realEstate').eq(i).find('.btn-buyerInfo').removeAttr('style'); 
          }//if
        }//for
      }).catch(function (err) {
        console.log(err.message);
      })
    },
      
    listenToEvents: function() {
      App.contracts.RealEstate.deployed().then(function (instance) {
        instance.LogBuyRealEstate({}, {fromBlock:0, toBlock:'latest'}).watch(function (error, event) {
            if (!error) {
              $('#events').append('<p>' + event.args._buyer + ' 계정에서 ' + event.args._id +
                ' 번 매물을 매입했습니다.' + '</p>');
            } else {
              console.log(error);
            }
            App.loadRealEstates();
          });
        })
    
    }
  };
  
  $(function() {
    $(window).load(function() {
      App.init();
      return App.initWeb3();
    });

    //Modal 띄어져 있으면
    $('#buyModal').on('show.bs.modal', function (e) {
      var id = $(e.relatedTarget).parent().find('.id').text();
      var temp_price = $(e.relatedTarget).parent().find('.price').text();
      //입력한 price ether => wei 로 변환한다.
      var price = web3.toWei(parseFloat(temp_price || 0), "ether");  
      //id와 price 를 Modal의 hidden tag에 저장한다.
      $(e.currentTarget).find('#id').val(id);
      $(e.currentTarget).find('#price').val(price);
    });
    
    //buyerInfoModal 띄어져 있으면
    $('#buyerInfoModal').on('show.bs.modal', function (e) {
    var id = $(e.relatedTarget).parent().find('.id').text();
    
    App.contracts.RealEstate.deployed().then(function(instance){
      return instance.getBuyerInfo.call(id);
    }).then(function (buyerInfo) {
      $(e.currentTarget).find('#buyerAddress').text(buyerInfo[0]);
      $(e.currentTarget).find('#buyerName').text(web3.toUtf8(buyerInfo[1]));
      $(e.currentTarget).find('#buyerAge').text(buyerInfo[2]);
    }).catch(function (err) {
      console.log(err.message);
    })
  });

  });
  