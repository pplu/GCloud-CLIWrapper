package GCloud::CLIWrapper;
  use Moose;
  use JSON::MaybeXS;
  use IPC::Open3;
  use GCloud::CLIWrapper::Result;

  has gcloud => (is => 'ro', isa => 'Str', default => 'gcloud');

  has gcloud_options => (is => 'ro', isa => 'ArrayRef[Str]', lazy => 1, default => sub { [ ] });

  sub command_for {
    my ($self, @params) = @_;
    return ($self->gcloud, @{ $self->gcloud_options }, @params);
  }

  sub run {
    my ($self, @command) = @_;
    return $self->input(undef, @command);
  }
 
  sub json {
    my ($self, @command) = @_;
 
    my $result = $self->run(@command);

    my $struct = eval {
      JSON->new->decode($result->output);
    };
    if ($@) {
      return GCloud::CLIWrapper::Result->new(
        rc => $result->rc,
        output => $result->output,
        success => 0
      );
    }
 
    return GCloud::CLIWrapper::Result->new(
      rc => $result->rc,
      output => $result->output,
      json => $struct
    );
  }
 
  sub input {
    my ($self, $input, @params) = @_;
 
    my @final_command = $self->command_for(@params);

    my ($stdin, $stdout, $stderr);
    my $pid = open3($stdin, $stdout, $stderr, @final_command);
    print $stdin $input  if(defined $input);
    close $stdin;

    my $out = join '', <$stdout>;
    my $err = join '', <$stderr> if ($stderr);

    die "Unexpected contents in stderr:\n $err" if ($err);
 
    waitpid( $pid, 0 );
    my $rc = $? >> 8;
 
    return GCloud::CLIWrapper::Result->new(
      rc => $rc,
      output => $out,
    );
  }

1;
