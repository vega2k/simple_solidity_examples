App = {
    web3Provider: null,
    contracts: {},

    initWeb3: function () {
        if (typeof web3 !== 'undefined') {
          App.web3Provider = web3.currentProvider;
          web3 = new Web3(App.web3Provider);
        } else {
          App.web3Provider = new web3.providers.HttpProvider('http://localhost:8545');
          web3 = new Web3(App.web3Provider);
        }
        return App.initContract();
     },
     initContract: function() {
        $.getJSON('Coursetro.json', function (data) {
          App.contracts.Coursetro = TruffleContract(data);
          App.contracts.Coursetro.setProvider(App.web3Provider);
          console.log('MyContract :', App.contracts.Coursetro);
          return App.getInstructor();
        });
     },	
     getInstructor: function() {
       App.contracts.Coursetro.deployed().then(function (instance) {
          console.log('instance ' + instance);
          return instance.getInstructor.call();
        }).then(function (result) {
            console.log(result[0], result[1]);
            //web3.toUtf8(result[0])
            $("#instructor").html(web3.toUtf8(result[0])+' ('+result[1]+' years old)');
        }).catch(function (err) {
            console.log(err.message);
        })
    },
    setInstructor: function () {
        var name = $('#name').val();
        var age = $('#age').val();
        App.contracts.Coursetro.deployed().then(function (instance) {
          return instance.setInstructor(web3.toHex(name), age);
        }).then(function () {
          $('#name').val('');
          $('#age').val('');
          return App.getInstructor();
        }).catch(function (err) {
          console.log(err.message);
        })
    } 
};

$(function () {
    $(window).load(function () {
        App.initWeb3();
    });
    $("#button").click(function () {
        App.setInstructor();
    });
});
