/**
* My BDD Test
*/
component extends="coldbox.system.testing.BaseTestCase" appMapping="root"{
	
/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		reset();
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		super.afterAll();
	}

/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "AutoDeploy Module", function(){

			it( "loaded successfully", function(){
				var deploy = getInstance( "interceptor-deploy@autodeploy" );
				expect(	deploy ).toBeComponent();
			});

		});
	}
	
}