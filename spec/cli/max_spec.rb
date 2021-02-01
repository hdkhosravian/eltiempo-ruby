describe './bin/eltiempo executing a CLI Application' do
  context "call the cli max temp successfully" do
    it 'with -av_max' do
      # we can't use stub request here because the cli is an external library
      expect { run_cli("./bin/eltiempo", '-av_max', 'Gavamar') }.to output(
        a_string_including
      ).to_stdout_from_any_process
    end

    it 'with -av-max' do
      # we can't use stub request here because the cli is an external library
      expect { run_cli("./bin/eltiempo", '-av-max', 'Gavamar') }.to output(
        a_string_including
      ).to_stdout_from_any_process
    end

    it 'with max' do
      # we can't use stub request here because the cli is an external library
      expect { run_cli("./bin/eltiempo", 'max', 'Gavamar') }.to output(
        a_string_including
      ).to_stdout_from_any_process
    end
  end
  
  it "list of cities contain name of the city" do
    # we can't use stub request here because the cli is an external library
    expect { run_cli("./bin/eltiempo", '-av_max', 'Gav') }.to output(
      a_string_including('we could not find the Gav, did you mean:')
    ).to_stdout_from_any_process
  end

  it "return error message if the name of city was wrong" do
    # we can't use stub request here because the cli is an external library
    expect { run_cli("./bin/eltiempo", '-av_max', 'test') }.to output(
      a_string_including('we could not find the test')
    ).to_stdout_from_any_process
  end
end
