require 'spec_helper'

def generate_slugs_job
     build( :json_job, 
            :job => build(:generate_slugs_job)
          )
end

describe "Generate slugs job" do

  let(:user) { create_nobody_user } 

  it "turns on autogenerate slugs for all supported types" do

    @resource  = Resource.create_from_json(build(:json_resource))
    @accession = Accession.create_from_json(build(:json_accession))
    @digital_object = DigitalObject.create_from_json(build(:json_digital_object))
    @classification = Classification.create_from_json(build(:json_classification))
    @repository_id = make_test_repo("slug_job_test")
    @subject = Subject.create_from_json(build(:json_subject))
    @agent_person = AgentPerson.create_from_json(build(:json_agent_person, :names => [build(:json_name_person, 'authorized' => false)]))
    @agent_corporate_entity = AgentCorporateEntity.create_from_json(build(:json_agent_corporate_entity))
    @agent_software = AgentSoftware.create_from_json(build(:json_agent_software))
    @agent_family = AgentFamily.create_from_json(build(:json_agent_family))

    json = generate_slugs_job
    job = Job.create_from_json(json, :user => user )
    jr = JobRunner.for(job) 
    jr.run

    Resource.any_repo.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    DigitalObject.any_repo.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    Accession.any_repo.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    Classification.any_repo.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    Repository.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    Subject.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    AgentFamily.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    AgentSoftware.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    AgentPerson.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end

    AgentCorporateEntity.each do |r|
      expect(r[:is_slug_auto]).to eq(1)
    end
  end

  it "results in a slug being created for all supported types" do
    @resource  = Resource.create_from_json(build(:json_resource))
    @accession = Accession.create_from_json(build(:json_accession))
    @digital_object = DigitalObject.create_from_json(build(:json_digital_object))
    @classification = Classification.create_from_json(build(:json_classification))
    @repository_id = make_test_repo("slug_job_test")
    @subject = Subject.create_from_json(build(:json_subject))
    @agent_person = AgentPerson.create_from_json(build(:json_agent_person, :names => [build(:json_name_person, 'authorized' => false)]))
    @agent_corporate_entity = AgentCorporateEntity.create_from_json(build(:json_agent_corporate_entity))
    @agent_software = AgentSoftware.create_from_json(build(:json_agent_software))
    @agent_family = AgentFamily.create_from_json(build(:json_agent_family))

    json = generate_slugs_job
    job = Job.create_from_json(json, :user => user )
    jr = JobRunner.for(job) 
    jr.run

    Resource.any_repo.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    DigitalObject.any_repo.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    Accession.any_repo.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    Classification.any_repo.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    Repository.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    Subject.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    AgentFamily.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    AgentSoftware.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    AgentPerson.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end

    AgentCorporateEntity.each do |r|
      expect(r[:slug]).to_not eq(nil)
    end
  end
end
