package ReplaceTags;

use File::Glob;
use Path::Tiny;

our $template_dir;
our $output_dir; 
our @templates;
our $replacements;

sub run {
    # match original algorithm
	$replacements = shift;
	process_template_files();
}

sub set_template_dir {
    my $dir = shift; 
    
    if ($dir) {
        $template_dir = path($dir);
    } else {
        $template_dir = path( __FILE__ )->parent->sibling->child('templates');
    }

    return $template_dir->realpath
        or die "Error! Template directory not found: $template_dir/n";
}

sub process_template_files {
    my %args = @_; 
    
    if ($args{tpldir}) { 
        set_template_dir($args{tpldir});
    } elsif (! $template_dir) {
        # set if not yet set
        set_template_dir;
    }

    my $tpl_ext = $arg{tplext} || 'tpl'; 

	my @templates = glob( $template_dir . "/*.$tpl_ext" ); # XXX improve

	for my $template ( @templates ) {

        if ($args{outdir}) {
            my $outputdir = path($args{outdir});
            if (is_dir($outputdir)) {
                my $output_ext = $arg{outext} || 'out'; 
                # slurp file, process, write to new output file
                path($outputdir, "$template.$output_ext")->spew_utf8(process_template(path($template)->slurp_utf8));
            }
        } else {
            # slurp file, process, spew back
            path($template)->spew_utf8(process_template(path($template)->slurp_utf8));
        }
        
	}
}

sub process_template {

    my $template_string = shift;

    $template_string =~ s/!expires!/$replacements->{expires}/ig;
    $template_string =~ s/!title!/$replacements->{title}/ig;
    $template_string =~ s/!content!/$replacements->{content}/ig;

    return $template_string;
}

1;

__END__

=pod

=head1 NAME

ReplaceTags - template conversion utility

=head1 SYNOPSIS

To update template files in the target directory containing the
tags !expires!, !title! and !content! with their corresponding
hash values:

    use ReplaceTags;

    use ReplaceTags;

    ReplaceTags::run({
        expires => 'Mon, 31 Dec 2012 12:00:00 GMT',
        title   => 'Replace Tags',
        content => 'Hello, World!',
    });

=head1 DESCRIPTION

This module converts template files containing tags of the form:

    !name_of_tag!

to files containing production-ready content. 

=head1 BUGS/CAVEATS/etc

This module might well benefit from becoming a class. 

=head1 AUTHOR

Ludo Tolhurst-Cleaver <camel@ltcdev.com>

=head1 COPYRIGHT and LICENSE

This software may be used on the same terms as Perl itself. 

=cut

