import rsdpandoc.builders
import rsdpandoc.globbers
        
env=Environment(tools=['default',rsdpandoc.builders.add_builders])
env["HavePIL"]=False
env["HaveWSD"]=False
env["HaveWebKit"]=False
rsdpandoc.globbers.reveal_layout('scholar/lecture.md',env,"reveal/scholar","scholar/asset_sources")
rsdpandoc.globbers.reveal_layout('version_control/lecture.md',env,"reveal/version_control","version_control/figures")
rsdpandoc.globbers.reveal_layout('fabric/lecture.md',env,"reveal/fabric")