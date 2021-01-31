describe './bin/eltiempo executing a CLI Application' do
  context "call the cli version successfully" do
    it 'with -v' do
      expect { run_cli("./bin/eltiempo", '-v') }.to output(
        a_string_including('1.0.0')
      ).to_stdout_from_any_process
    end

    it 'with --v' do
      expect { run_cli("./bin/eltiempo", '--v') }.to output(
        a_string_including('1.0.0')
      ).to_stdout_from_any_process
    end

    it 'with --version' do
      expect { run_cli("./bin/eltiempo", '--version') }.to output(
        a_string_including('1.0.0')
      ).to_stdout_from_any_process
    end
  end
end
