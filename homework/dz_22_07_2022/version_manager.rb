class VersionManager
  def initialize(version = nil)
    @actions = []
    if !version.nil?
      strings = version.split('.')
      @major = Integer(strings[0]) # генерит ArgumentError если не может к integer преобразовать
      strings.size > 1 ? @minor = Integer(strings[1]) : @minor = 0
      strings.size > 2 ? @patch = Integer(strings[2]) : @patch = 0
      @patch = 1 if @major == 0 && @minor == 0 && @patch == 0
    else
      @major = 0
      @minor = 0
      @patch = 1
    end
  end

  def major!
    @actions.push([@major, @minor, @patch])
    @major += 1
    @minor = 0
    @patch = 0
  end

  def minor!
    @actions.push([@minor, @patch])
    @minor += 1
    @patch = 0
  end

  def patch!
    @actions.push([@patch])
    @patch += 1
  end

  def rollback!
    last_version = @actions.pop
    raise "It's first version" if last_version.nil?
    (@major = last_version[0]; @minor = last_version[1]; @patch = last_version[2]) if last_version.size == 3
    (@minor = last_version[0]; @patch = last_version[1]) if last_version.size == 2
    @patch = last_version[0] if last_version.size == 1
  end

  def release
    to_s
  end

  def to_s
    "#{@major}.#{@minor}.#{@patch}"
  end
end