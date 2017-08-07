/**
* My BDD Test
*/
component extends="coldbox.system.testing.BaseTestCase"{
	
/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		reset();
		var configTagPath = expandPath( "/root/config/_deploy.tag" );
		if( fileExists( configTagPath ) ){
			fileDelete( configTagPath );
		}
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