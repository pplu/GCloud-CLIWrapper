# NAME

GCloud::CLIWrapper - Module to use Google Cloud APIs via the gcloud CLI

# SYNOPSIS

     use GCloud::CLIWrapper;
    
     my $api = GCloud::CLIWrapper->new();
    
     my $result = $api->run('info');
     # $result->success == 1 if the command executed correctly
     # $result->output contains the output of the command
    
     my $result = $api->json('info', '--format', 'json');
     # $result->success == 1 if the command executed correctly
     # $result->output contains the output of the command
     # $result->json is a hashref with the result of the parsed JSON output of the command
    

# DESCRIPTION

This module helps you use the GCloud API. It sends all it's commands
via the CLI command line tool `gcloud`. 

# ATTRIBUTES

## glcloud

By default initialized to `gcloud`. It will try to find kubectl in the PATH. You can
set it explicitly to a specific gcloud excecutable.

## gcloud\_options

An ArrayRef of options to always add to the command line invocations.

     my $api = GCloud::CLIWrapper->new(
       gcloud_options => [ 'info' ],
     );
    
     my $result = $api->run;
     # $result->success == 1 if the command executed correctly
     # $result->output contains the output of the command
    
     my $result = $api->json('--format', 'json');
     # $result->success == 1 if the command executed correctly
     # $result->output contains the output of the command
     # $result->json is a hashref with the result of the parsed JSON output of the command
    

# METHODS

## run(@parameters)

Will run gcloud with the parameters. Returns a [GCloud::CLIWrapper::Result](https://metacpan.org/pod/GCloud::CLIWrapper::Result) object
with `output` set to the output of the command, and `success` a Boolean to indicate
if the command reported successful execution.

## json(@parameters)

Will run gcloud with the parameters, trying to parse the output as json. Note that you are
responsible for passing the command-line option to output in a json format. Returns a [Kubectl::CLIWrapper::Result](https://metacpan.org/pod/Kubectl::CLIWrapper::Result) object
with `output` set to the output of the command, and `json` set to a hashref with the parsed
JSON. `success` will be false if JSON parsing fails.

# SEE ALSO

[https://cloud.google.com/sdk/gcloud/](https://cloud.google.com/sdk/gcloud/)

# AUTHOR

       Jose Luis Martinez
       CAPSiDE
       jlmartinez@capside.com
    

# BUGS and SOURCE

The source code is located here: [https://github.com/pplu/GCloud-CLIWrapper.git](https://github.com/pplu/GCloud-CLIWrapper.git)

Please report bugs to: [https://github.com/pplu/GCloud-CLIWrapper/issues](https://github.com/pplu/GCloud-CLIWrapper/issues)

# COPYRIGHT and LICENSE

Copyright (c) 2018 by CAPSiDE
This code is distributed under the Apache 2 License. The full text of the 
license can be found in the LICENSE file included with this module.
