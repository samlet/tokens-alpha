from typing import Text, Any, Dict, List, Union, Optional, Tuple

import pandas as pd
import json
import streamlit as st

# from interacts.common import display_lang_selector
from interacts.sl_utils import all_labels, write_styles
from interacts.tracker_streamlit import enable_streamlit_tracker
from brownie import project, network, accounts

enable_streamlit_tracker()
write_styles()

def to_df(list_of_tuples:List[Tuple], columns:List[Text]) -> pd.DataFrame:
    return pd.DataFrame(list_of_tuples, columns=columns)

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
        st.markdown(f"**{contract_name}** doesn't have a default constructor.")

def show_source(proj, contract_name):
    from streamlit_ace import st_ace
    sources = proj._sources
    src = sources.get(contract_name)
    content = st_ace(
        placeholder=st.sidebar.text_input("Editor placeholder.", value=''),
        language='solidity',
        theme='xcode',
        keybinding="sublime",
        font_size=st.sidebar.slider("Font size.", 5, 24, 12),
        tab_size=st.sidebar.slider("Tab size.", 1, 8, 4),
        show_gutter=True,
        show_print_margin=True,
        wrap=st.sidebar.checkbox("Wrap enabled.", value=False),
        readonly=st.sidebar.checkbox("Read-only.", value=False, key="ace-editor"),
        key="ace-editor"
    )

    # st.write(content)

def inputs(f):
    return ', '.join([p['name'] for p in f['inputs']])

def show_abi(proj, contract_name):
    build = proj._build
    c = build.get(contract_name)
    # abi=c['abi']
    # st.write(abi)
    df=to_df([(f['name'], f['type'],
              f['stateMutability'] if 'stateMutability' in f else '_',
              inputs(f),
             )
             for f in c['abi']], ['name', 'type', 'stateMutability', 'inputs'])
    # st.dataframe(df)
    st.table(df)

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
    # show_source(proj, contract_name)
    show_abi(proj, contract_name)
    manage_token(proj, contract_name)

if __name__ == '__main__':
    main()

