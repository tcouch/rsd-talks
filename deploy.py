# Modify the config files to the version used in deployment
import yaml

deployed_path="/talks"

plugin=yaml.load(open('dexyplugin.yaml'))
plugin['reporter:supplementary']['supplementary-location']='../indigo'
plugin['reporter:supplementary']['root']=deployed_path
yaml.dump(plugin,open('dexyplugin.yaml','w'))

dexy=yaml.load(open('dexy.yaml'))
dexy['.md|jinja|pandoc|-reveal|resub|h'
     ][2]['resub']['expressions'][1][1]=deployed_path
yaml.dump(dexy,open('dexy.yaml','w'))
