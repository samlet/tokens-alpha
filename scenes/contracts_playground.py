import streamlit as st

# from interacts.common import display_lang_selector
from interacts.sl_utils import all_labels, write_styles
from interacts.tracker_streamlit import enable_streamlit_tracker
from brownie import project, network, accounts

enable_streamlit_tracker()
write_styles()

def sidebar():
    # cur_lang=display_lang_selector()
    st.sidebar.subheader("Projects")
    options = ("token", "crowdsale", 'oracles')
    proj = st.sidebar.selectbox("select a project:", options, 0)
    return proj

def load_proj(proj_name:str):
    p = project.load(f'../{proj_name}', name=proj_name)
    p.load_config()
    # from brownie.project.oracles import *
    if not network.is_connected():
        network.connect('development')
    return p

def get_proj(proj_name:str):
    return next(p for p in project.get_loaded_projects() if p._name == proj_name)

def reload(proj_name:str):
    btn_reload = st.sidebar.button("Reload Project")
    if btn_reload:
        st.sidebar.markdown(f"reload project -> **{proj_name}**.")
        proj=get_proj(proj_name)
        proj.close(False)
        proj.load()
        proj.load_config()
        print(f'.. reloaded {proj_name}')

def list_contracts(proj):
    contract_names = list(dict(proj).keys())
    st.sidebar.subheader("Contracts")
    contract_name = st.sidebar.radio("select a contract:", contract_names, 0)
    st.markdown(f"contract: **{contract_name}**")
    return contract_name

def manage_token(proj, contract_name):
    contract=proj[contract_name]
    try:
        f = contract.deploy({'from': accounts[0]})
        st.write(f)
    except ValueError as e:
        st.markdown(f'**{contract_name}** is not a token.')

def main():
    proj_name=sidebar()
    st.subheader(f"Project ◇ {proj_name}")
    loaded_projs=project.get_loaded_projects()
    # print([p._name for p in loaded_projs])
    reload(proj_name)
    if proj_name not in [p._name for p in loaded_projs]:
        proj=load_proj(proj_name)
    else:
        proj=next(p for p in loaded_projs if p._name==proj_name)

    contract_name=list_contracts(proj)
    manage_token(proj, contract_name)

if __name__ == '__main__':
    main()

