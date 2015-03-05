define(['js.mobile.client'], function(Client){
  it("is a simple test", function(){
    var client = new Client();
    expect(client).toBeDefined();
  });
});
