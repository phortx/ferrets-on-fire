require 'ferrets_on_fire'
require 'ferrets_on_fire/dsl'
require 'ferrets_on_fire/dsl/logger_dsl'
require 'colorize'

describe FerretsOnFire::DSL::LoggerDSL do
  subject { Class.new { extend FerretsOnFire::LoggerDSL } }

  describe '#banner' do
    context 'with no colors given' do
      it 'returns the banner with white text and black background' do
        str = 'example'
        expectation = str.colorize(color: :white, background: :black) + "\n"
        expect { subject.banner(str) }.to output(expectation).to_stdout
      end
    end

    context 'with text color given' do
      it 'returns the banner with green text and black background' do
        str = 'example'
        expectation = str.colorize(color: :green, background: :black) + "\n"
        expect { subject.banner(str, color: :green) }.to output(expectation).to_stdout
      end
    end

    context 'with background color given' do
      it 'returns the banner with white text and blue background' do
        str = 'example'
        expectation = str.colorize(color: :white, background: :blue) + "\n"
        expect { subject.banner(str, background: :blue) }.to output(expectation).to_stdout
      end
    end
  end


  describe '#info' do
    it 'prints the text without color' do
      str = 'example'
      expect { subject.info(str) }.to output("[i] #{str}\n").to_stdout
    end
  end


  describe '#warn' do
    it 'prints the text in yellow' do
      str = 'example'
      expect { subject.warn(str) }.to output("[!] #{str}".yellow + "\n").to_stdout
    end
  end


  describe '#error' do
    it 'prints the text in red' do
      str = 'example'
      expect { subject.error(str) }.to output("[X] #{str}".red + "\n").to_stdout
    end
  end


  describe '#success' do
    it 'prints the text in green' do
      str = 'example'
      expect { subject.success(str) }.to output("[✔] #{str}".green + "\n").to_stdout
    end
  end


  describe '#choose' do
    # FIXME
  end


  describe '#yes_no' do
    # FIXME
  end


  describe '#linebreak' do
    it 'prints a linebreak' do
      expect { subject.linebreak }.to output("\n").to_stdout
    end
  end

  describe '#highlight' do
    it 'highlights the string in blue' do
      str = 'example'
      expect(subject.highlight(str)).to eq(str.light_blue)
    end
  end


  describe '#crash' do
    # FIXME
  end


  describe '#action' do
    # FIXME
  end


  describe '#_shell_action' do
    # FIXME
  end


  describe '#log' do
    # FIXME
  end
end
