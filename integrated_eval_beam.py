from translate_beam import main as translate_main
import logging
import typer
import argparse
import os 
import sys
import json

def main(log_file: str = typer.Option(None, help="Log file"),
            cuda: bool = typer.Option(True, help="Use a GPU"),
            data:str = 'data/en-fr/prepared',
            dicts:str = 'data/en-fr/sp_all',
            source_lang:str = 'fr',
            target_lang:str = 'en',
            max_tokens:int = None,
            batch_size:int = 4,
            bpe:bool = True,
            train_on_tiny:bool = False,
            arch:str = 'lstm',
            max_epoch:int = 10000,
            clip_norm:float = 4.0,
            lr:float = 0.0003,
            patience:int = 5,
            save_dir:str = 'assignments/03/bpe_dropout',
            restore_file:str = 'checkpoint_last.pt',
            save_interval:int = 1,
            no_save:bool = False,
            epoch_checkpoints:bool = False,
            beam_size:int = 5,
            alpha:float = 0.0,
            lambda_sq:float = 0.0,
            output_best:int = 1,
            gamma:float = 1.0,
    ):
    logging.basicConfig(filename=log_file, filemode='a', level=logging.INFO,
                        format='%(levelname)s: %(message)s')
    if log_file is not None:
        # Logging to console
        console = logging.StreamHandler()
        console.setLevel(logging.INFO)
        logging.getLogger('').addHandler(console)

    args = argparse.Namespace(cuda=cuda,
                              data=data,
                                dicts=dicts,
                                bpe=bpe,
                              source_lang=source_lang,
                              target_lang=target_lang,
                              max_tokens=max_tokens,
                              batch_size=batch_size,
                              train_on_tiny=train_on_tiny,
                              arch=arch,
                              max_epoch=max_epoch,
                              clip_norm=clip_norm,
                              lr=lr,
                              patience=patience,
                              save_dir=save_dir,
                              restore_file=restore_file,
                              save_interval=save_interval,
                              no_save=no_save,
                              epoch_checkpoints=epoch_checkpoints,
                                beam_size=beam_size,
                                alpha=alpha,)
    model_file = os.path.join(args.save_dir, args.restore_file)
    translations_output_file = os.path.join(args.save_dir, 'new/translations')
    translations_output_file = translations_output_file+f'_{beam_size}_alp{alpha}_gma{gamma}.txt'
    translate_args = argparse.Namespace(data=args.dicts,
                                        dicts=args.dicts,
                                        checkpoint_path=model_file,
                                        batch_size=32,
                                        bpe=args.bpe,
                                        output=translations_output_file,
                                        max_len=128,
                                        cuda=args.cuda,
                                        seed=42,
                                        beam_size=beam_size,
                                        alpha=alpha,
                                        lambda_sq=lambda_sq,
                                        output_best=output_best,
                                        gamma=gamma,
    )
    elapsed = translate_main(translate_args)
    #compute bleu score
    import sacrebleu
    with open(translations_output_file) as f:
        translations = f.readlines()
    if translations[0][0] == '[': # we have a serialized list
        translations_lists = [eval(t) for t in translations]
        translations = [t[0] for t in translations_lists]
    with open(os.path.join('data/en-fr/raw', 'test.en')) as f:
        references = f.readlines()
    bleu = sacrebleu.corpus_bleu(translations, [references])
    bleu_dict = {'bleu': bleu.score, 'bp': bleu.bp, 'ratio': bleu.ratio, 'hyp_len': bleu.sys_len, 'ref_len': bleu.ref_len, 'precisions': bleu.precisions, 'beam_size': beam_size, 'alpha': alpha, 'elapsed_t': elapsed}
    json_str = json.dumps(bleu_dict)
    print(json_str)



if __name__ == '__main__':
    typer.run(main)