require 'rails_helper'

RSpec.describe Page, type: :model do
  before(:each) do
    @page = Page.new
  end

  it "should require name" do
    @page.name = nil
    @page.should_not be_valid
  end

  it "should pass valid names (letters or numbers only)" do
    @page.name = "name1"
    expect(@page).to be_valid
    @page.name = "letTERS"
    expect(@page).to be_valid
    @page.name = "БУКвы"
    expect(@page).to be_valid
    @page.name = "0123456789"
    expect(@page).to be_valid
  end

  it "should failed invalid names" do
    @page.title = "incorrect title"
    for inc in '!@#$%^&*().,'.split("")
      @page.name = "hello" + inc
      expect(@page).not_to be_valid
    end
  end

  it "should parse <b>content</b>" do
    @page.name = "name"
    @page.content = "**content**"
    @page.save
    expect(@page.content_raw).to include("<b>content</b>")
  end

  it "should parse <i>content</i>" do
    @page.name = "name"
    @page.content = "\\\\content\\\\"
    @page.save
    expect(@page.content_raw).to include("<i>content</i>")
  end

  it "should parse <a>content</a>" do
    @page.name = "name"
    @page.content = "((name1[content]))"
    @page.save
    expect(@page.content_raw).to include("<a href=\"name1\">content</a>")
  end

  it "should parse <b><i><a>content</a></i></b>" do
    @page.name = "name"
    @page.content = "**\\\\((name1[content]))\\\\**"
    @page.save
    expect(@page.content_raw).to include("<b><i><a href=\"name1\">content</a></i></b>")
  end
end
