namespace: io.cloudslang.microfocus.bug
flow:
  name: reproduce_bug
  workflow:
    - get_token:
        do:
          io.cloudslang.microfocus.rpa.designer.authenticate.get_token: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: get_ws_id
    - get_ws_id:
        do:
          io.cloudslang.microfocus.rpa.designer.workspace.get_ws_id: []
        publish:
          - ws_id
        navigate:
          - FAILURE: on_failure
          - SUCCESS: get_projects
    - get_projects:
        do:
          io.cloudslang.microfocus.rpa.designer.project.get_projects:
            - ws_id: '${ws_id}'
        publish:
          - projects_json
        navigate:
          - FAILURE: on_failure
          - SUCCESS: json_path_query
    - json_path_query:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${projects_json}'
            - json_path: "$.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.children.[?(@.fileName == '_get_status.sl')].id"
        publish:
          - file_id: '${return_result[2:-2]}'
        navigate:
          - SUCCESS: get_file
          - FAILURE: on_failure
    - get_file:
        do:
          io.cloudslang.microfocus.rpa.designer.project.get_file:
            - ws_id: '${ws_id}'
            - file_id: '${file_id}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_token:
        x: 85
        'y': 110
      get_ws_id:
        x: 307
        'y': 108
      get_projects:
        x: 482
        'y': 120
      json_path_query:
        x: 587
        'y': 284
      get_file:
        x: 222
        'y': 310
        navigate:
          05d1780f-3f1e-0627-d90e-1a332888787c:
            targetId: ec89fa8e-6016-a186-603d-a048e9cd826c
            port: SUCCESS
    results:
      SUCCESS:
        ec89fa8e-6016-a186-603d-a048e9cd826c:
          x: 416
          'y': 473
