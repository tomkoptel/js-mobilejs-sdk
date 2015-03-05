define('test', function() {
  describe('DashboardWrapper', function() {
     it("should be defined in window scope", function(){
       var DashboardWrapper = window.DashboardWrapper;
       expect(DashboardWrapper).toBeDefined();
     });
   });
});
