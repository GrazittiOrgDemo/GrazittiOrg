<project name="Sample" basedir=".." xmlns:sf="antlib:com.salesforce">
    <property environment="env"/>
    <target name="deploy">
      <sf:deploy username="${sf.username}" 
        password="${sf.password}" 
        serverurl="${sf.serverUrl}" 
        maxPoll="200"
        pollWaitMillis="500000"
        testLevel="${sf.testLevel}"
        deployRoot="src" 
        checkOnly="${sf.checkOnly}" />
    </target>
</project>
