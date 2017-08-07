/*********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
*******************************************************************************
The magic of auto deployments	
**/
component extends="coldbox.system.Interceptor" accessors="true"{

	/**
	* The tag file location
	*/
	property name="tagFilePath" 		default="";
	/**
	* The deploy command object to execute.
	*/
	property name="deployCommandObject" default="";
	/**
	* Relocate to another URL if a deploy is detected.
	*/
	property name="relocateOnDeploy" 	default="";

	/**
	* Configure the interceptor
	*/
	function configure(){
	}

	/**
	* Register the tag
	*/
	function afterConfigurationLoad(){
		// Setup Configuration
		variables.moduleConfig 			= controller.getSetting( "autoDeploy" );
		variables.tagFilepath 			= locateFilePath( variables.moduleConfig.tagFile );
		variables.deployCommandObject 	= variables.moduleConfig.deployCommandObject;
		variables.relocateOnDeploy 		= variables.moduleConfig.relocateOnDeploy;
			
		// Validate Timestamp exists, else create one.
		if( len( variables.tagFilepath ) eq 0 ){
			// Verify absolute or relative
			var oFile = createObject( "java", "java.io.File" ).init( variables.moduleConfig.tagFile );
			if( oFile.isAbsolute() ){
				variables.tagFilePath = variables.moduleConfig.tagFile;
			} else {
				variables.tagFilePath = expandPath( "#controller.getSetting( 'appMapping' )#/#variables.moduleConfig.tagFile#" );
			}
			// Create it
			fileWrite( variables.tagFilepath , "DEPLOYING ON: #now()#" );
		}
		
		// Save TimeStamp
		setSetting( "_deploytagTimestamp", getFileInfo( variables.tagFilepath ).lastModified );
		
		if( log.canInfo() ){
			log.info( "Deploy tag registered successfully." );
		}
	}

	/**
	* Function at post process
	*/
	function postProcess( event, interceptData ){
		// get the timestamp of the configuration file
		var tagTimestamp = getFileInfo( variables.tagFilepath ).lastModified;
		
		// Check if setting exists
		if ( settingExists( "_deploytagTimestamp" ) ){
			// get current timestamp
			var appTimestamp = getSetting( "_deploytagTimestamp" );
			
			//Validate Timestamp
			if ( dateCompare( tagTimestamp, appTimestamp ) eq 1 ){
				lock scope="application" type="exclusive" timeout="25" throwOntimeout="true"{
					// concurrency lock
					if ( dateCompare( tagTimestamp, appTimestamp ) eq 1 ){
						try{
							// commandobject
							if( len( variables.deployCommandObject ) ){
								getInstance( variables.deployCommandObject ).execute();
								// Log
								if( log.canInfo() ){
									log.info( "Deploy command object executed!" );
								}
							}
							
							// Log Reloading
							if( log.canInfo() ){
								log.info( "Deploy tag reloaded successfully." );
							}

							// Mark Application for shutdown
							applicationStop();

							// Relocate if config setting has URL for this to take effect
							if( len( variables.relocateOnDeploy ) ){
								location( variables.relocateOnDeploy, "false", "302" );
							}
							
						} catch( Any e ){
							//Log Error
							log.error( "Error in deploy tag: #e.message# #e.detail#", e.stackTrace );
						}
					} // end if dateCompare
				} //end lock
			} // end if dateCompare

			// stop interception chain
			return true;
			
		} // end if setting exists
		else {
			configure();
		}
	}

}