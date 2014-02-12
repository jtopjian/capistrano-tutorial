require 'colorize'

module Helpers

  # Renders a template
  def render_template(template, output, scope)
    require 'erb'
    tmpl = File.read(template)
    erb = ERB.new(tmpl, 0, "<>")
    File.open(output, 'w') do |f|
      f.puts erb.result(scope)
    end
  end

  # color output
  def cap_info message
    puts " INFO #{message}".colorize(:cyan)
  end

  def cap_warn message
    puts " WARN #{message}".colorize(:yellow)
  end

  def cap_error message
    puts " ERROR #{message}".colorize(:red)
  end

  # Upload and Move
  def upload_and_move file, source, destination
    if File.exists?("#{source}/#{file}")
      upload! "#{source}/#{file}", './'
      sudo "mv ./#{file} #{destination}"
    end
  end

  def upload_and_move_if_changed file, source, destination
    if File.exists?("#{source}/#{file}")
      if md5_diff? file, source, destination
        upload_and_move file, source, destination
      end
    end
  end

  # Calculate the md5 of a local and remote file
  def md5_diff? file, source, destination
    f = nil
    if test("[ -f #{destination} ]")
      f = destination
    elsif test("[ -d #{destination} ]")
      if test("[ -f #{destination}/#{file} ]")
        f = "#{destination}/#{file}"
      end
    end

    if f
      md5_source = %x(ruby -r 'digest/md5' -e "puts Digest::MD5.file('#{source}/#{file}')").strip!
      md5_dest = capture(%Q!ruby -r 'digest/md5' -e "puts Digest::MD5.file('#{f}')"!)
      md5_dest.strip!

      if md5_source != md5_dest
        return true
      else
        return false
      end
    else
      return true
    end
  end

end

include Helpers
