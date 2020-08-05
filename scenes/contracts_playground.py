from typing import Text, Any, Dict, List, Union, Optional, Tuple

import pandas as pd
import json
import streamlit as st

# from interacts.common import display_lang_selector
from interacts.sl_utils import all_labels, write_styles
from interacts.tracker_streamlit import enable_streamlit_tracker
from brownie import project, network, accounts

from scenes.scene_states import contract_instances

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
        contract_instances.clear()

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

def get_contract(proj_name:str, contract_name:str):
    cname=f"{proj_name}.{contract_name}"
    if cname in contract_instances:
        return contract_instances[cname]
    try:
        proj=get_proj(proj_name)
        contract = proj[contract_name]
        f = contract.deploy({'from': accounts[0]})
        contract_instances[cname]=f
        return f
    except ValueError as e:
        st.markdown(f"**{contract_name}** doesn't have a default constructor.")
        return None

# def manage_token(proj, contract_name):
#     contract=proj[contract_name]
#     try:
#         f = contract.deploy({'from': accounts[0]})
#         st.write(f)
#         return f
#     except ValueError as e:
#         st.markdown(f"**{contract_name}** doesn't have a default constructor.")

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

def input_widgets(prefix, inputs:List[Dict[Text, Text]]):
    # 'inputs': [{'name': '_id', 'type': 'bytes32'},
    #    {'name': 'result', 'type': 'string'}],
    args=[]
    for i, input in enumerate(inputs):
        value = st.text_input(f"{input['name']} ({input['type']})", "", key=f"{prefix}_{i}")
        args.append(value)
    return args

def show_functions(proj, contract_name, instance):
    from brownie.network.transaction import TransactionReceipt
    contract=proj[contract_name]
    for func in contract.abi:
        if func['type']=='function':
            fname = f"{func['name']} ({len(func['inputs'])})"
            args=input_widgets(fname,  func['inputs'])
            if st.button(f"Invoke: {fname}"):
                fn = getattr(instance, func['name'], None)
                tx=fn(*args)
                st.write(tx.return_value if isinstance(tx, TransactionReceipt) else tx)

def print_info():
    print(accounts)

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

    # print_info()
    contract_name=list_contracts(proj)
    # show_source(proj, contract_name)
    show_abi(proj, contract_name)
    # inst=manage_token(proj, contract_name)
    inst = get_contract(proj_name, contract_name)
    if inst:
        st.write(inst)
        show_functions(proj, contract_name, inst)
    else:
        st.write('No instance.')

if __name__ == '__main__':
    main()

